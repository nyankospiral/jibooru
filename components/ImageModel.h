#pragma once

#include <QAbstractListModel>
#include <QUrl>
#include <QVector>
#include <QStringList>
#include <QVariantMap>

class ImageModel : public QAbstractListModel
{
	Q_OBJECT
public:
	explicit ImageModel(QObject *parent = nullptr);

	enum ImageRoles {
		FileUrlRole = Qt::UserRole + 1,
		PixelWidthRole,
		PixelHeightRole,
		KeywordsRole
	};

	int rowCount(
		const QModelIndex &parent = QModelIndex()
	) const override;

	QVariant data (
		const QModelIndex &index,
		int role = Qt::DisplayRole
	) const override;
	
	QHash<int, QByteArray> roleNames() const override;

	Q_INVOKABLE void loadFolder(const QString &folderPath);
	Q_INVOKABLE void setKeywordFilter(const QStringList &keywords);
	Q_INVOKABLE QVariantMap entryAt(int row) const;

private:
	struct ImageEntry {
		QUrl fileUrl;
		int width;
		int height;
		QStringList keywords;
	};

	bool readKeywords(
		const QString &filePath,
		ImageEntry &image
	);

	bool matchesKeywordFilter(
		const ImageEntry &image
	) const;

	QVector<ImageEntry> m_allImages;
	QVector<ImageEntry> m_images;

	QStringList m_requiredKeywords;
};
