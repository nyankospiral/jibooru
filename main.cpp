#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "components/ImageModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	ImageModel imageModel;

    QQmlApplicationEngine engine;
	
	engine.rootContext()->setContextProperty(
		"imageModel",
		&imageModel
	);

	engine.load("main.qml");

	if (engine.rootObjects().isEmpty())
		return -1;

    return app.exec();
}
