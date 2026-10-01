#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>
#include <QUrl>
#include <QString>

#include "components/ImageModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	ImageModel imageModel;
	imageModel.loadFolder(QStandardPaths::writableLocation(QStandardPaths::HomeLocation));

    QQmlApplicationEngine engine;
	
	engine.rootContext()->setContextProperty(
		"imageModel",
		&imageModel
	);

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	if (engine.rootObjects().isEmpty())
		return -1;

    return app.exec();
}
