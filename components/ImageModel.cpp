#include "ImageModel.h"

#include <QDir>
#include <QFileInfo>
#include <QImageReader>
#include <QStringList>
#include <QStringList>
#include <QVariantMap>
#include <QDebug>

#include <exiv2/exiv2.hpp>

ImageModel::ImageModel(QObject *parent)
	: QAbstractListModel(parent)
{
}

int ImageModel::rowCount(const QModelIndex &parent) const
{
	if (parent.isValid())
		return 0;

	return m_images.size();
}

QVariant ImageModel::data(
	const QModelIndex &index,
	int role
) const
{
	if (!index.isValid())
		return {};

	if(index.row() < 0 || index.row() >= m_images.size())
		return {};

	const ImageEntry &image = m_images.at(index.row());

	switch (role) {
		case FileUrlRole:
			return image.fileUrl;
			
		case PixelWidthRole:
			return image.width;

		case PixelHeightRole:
			return image.height;

		case KeywordsRole:
			return image.keywords;

		default:
			return {};
	}
}

QHash<int, QByteArray> ImageModel::roleNames() const
{
	return {
		{ FileUrlRole, "fileUrl" },
		{ PixelWidthRole, "pixelWidth" },
		{ PixelHeightRole, "pixelHeight" },
		{ KeywordsRole, "keywords" }
	};
}

bool ImageModel::readKeywords(
	const QString &filePath,
	ImageEntry &image
)
{
	try {
		auto exivImage =
			Exiv2::ImageFactory::open(filePath.toStdString());

		if (!exivImage)
			return false;

		exivImage->readMetadata();

		const Exiv2::IptcData &iptcData = 
			exivImage->iptcData();

		const std::string keywordKey =
			"Iptc.Application2.Keywords";

		image.keywords.clear();

		for (auto it = iptcData.begin();
				it != iptcData.end();
				++it) {

			if (it->key() == keywordKey) {
				image.keywords.append(
					QString::fromStdString(it->toString())
				);
			}
		}

		return true;
	}
	catch (const Exiv2::Error &error) {
		qWarning()
			<< "Could not read keywords from"
			<< filePath
			<< ":"
			<< error.what();

		return false;
	}
}

bool ImageModel::matchesKeywordFilter(const ImageEntry &image) const
{
	//no filter, show all images
	if (m_requiredKeywords.isEmpty())
		return true;

	for (const QString &requiredKeyword : m_requiredKeywords){
		bool found = false;

		for (const QString &imageKeyword : image.keywords) {
			if (imageKeyword.compare(
						requiredKeyword,
						Qt::CaseInsensitive
						) == 0) {
				found = true;
				break;
			}
		}

		if (!found)
			return false;
	}

	return true;
}

void ImageModel::setKeywordFilter(const QVariantList &keywords)
{
    m_requiredKeywords.clear();

    for (const QVariant &value : keywords) {
        const QString keyword = value.toString().trimmed();

        if (!keyword.isEmpty())
            m_requiredKeywords.append(keyword);
    }

    beginResetModel();

    m_images.clear();

    for (const ImageEntry &image : m_allImages) {
        if (matchesKeywordFilter(image))
            m_images.append(image);
    }

    endResetModel();

}

void ImageModel::loadFolder(const QString &folderPath)
{
    QDir directory(folderPath);

    const QStringList nameFilters = {
        "*.jpg",
        "*.jpeg",
        "*.png",
        "*.webp"
    };

    const QFileInfoList files = directory.entryInfoList(
        nameFilters,
        QDir::Files | QDir::Readable,
        QDir::Name
    );

    beginResetModel();

    m_allImages.clear();
    m_images.clear();

    for (const QFileInfo &file : files) {
        QImageReader reader(file.absoluteFilePath());

        const QSize imageSize = reader.size();

        if (!imageSize.isValid())
            continue;

        ImageEntry image;

        image.fileUrl =
            QUrl::fromLocalFile(
                file.absoluteFilePath()
            );

        image.width = imageSize.width();
        image.height = imageSize.height();

        readKeywords(
            file.absoluteFilePath(),
            image
        );

        m_allImages.append(image);

        if (matchesKeywordFilter(image))
            m_images.append(image);
    }

    endResetModel();

}


QVariantMap ImageModel::entryAt(int row) const
{
    if (row < 0 || row >= m_images.size())
        return {};

    const ImageEntry &image = m_images.at(row);

    QVariantMap result;

    result["fileUrl"] = image.fileUrl;
    result["pixelWidth"] = image.width;
    result["pixelHeight"] = image.height;
    result["keywords"] = image.keywords;

    return result;
}

