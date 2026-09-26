#include "ImageModel.h"

#include <QDir>
#include <QFileInfo>
#include <QImageReader>

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

		default:
			return {};
	}
}

QHash<int, QByteArray> ImageModel::roleNames() const
{
	return {
		{ FileUrlRole, "fileUrl" },
		{ PixelWidthRole, "pixelWidth" },
		{ PixelHeightRole, "pixelHeight" }
	};
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

	m_images.clear();

	for (const QFileInfo &file : files){
		QImageReader reader(file.absoluteFilePath());
		
		const QSize imageSize = reader.size();

		if (!imageSize.isValid())
			continue;

		ImageEntry image;
		image.fileUrl = QUrl::fromLocalFile(file.absoluteFilePath());
		image.width = imageSize.width();
		image.height = imageSize.height();

		m_images.append(image);
	}

	endResetModel();
}
