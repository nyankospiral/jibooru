#pragma once

#include <QAbstractListModel>
#include <QUrl>
#include <QVector>

class ImageModel : public QAbstractListModel
{
	Q_OBJECT
public:
	explicit ImageModel(QObject *parent = nullptr);

	enum ImageRoles {
		FileUrlRole = Qt::UserRole + 1,
		PixelWidthRole,
		PixelHeightRole
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

private:
	struct ImageEntry {
		QUrl fileUrl;
		int width;
		int height;
	};

	QVector<ImageEntry> m_images;
};
