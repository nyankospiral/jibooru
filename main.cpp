#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>

#include "components/ImageModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	ImageModel imageModel;
	imageModel.loadFolder(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));

    QQmlApplicationEngine engine;
	
	engine.rootContext()->setContextProperty(
		"imageModel",
		&imageModel
	);

	engine.loadFromModule("jibooru_modules", "Main");

	if (engine.rootObjects().isEmpty())
		return -1;

    return app.exec();
}
