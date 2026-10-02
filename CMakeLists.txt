cmake_minimum_required(VERSION 3.16)
project(jibooru VERSION 1.0 LANGUAGES C CXX)

include(GNUInstallDirs)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)
find_package(exiv2 CONFIG REQUIRED)

qt_standard_project_setup()

set_source_files_properties(
	AppSettings.qml
	PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_executable(jibooru WIN32 MACOSX_BUNDLE
    components/ImageModel.cpp components/ImageModel.h
    main.cpp
	resources.qrc
)

qt_add_qml_module(jibooru
    URI jibooru_modules
	QML_FILES AppSettings.qml
    VERSION ${PROJECT_VERSION}
)

# Avoid collision between executable name and QML module directory (QTBUG-98568).
if(NOT WIN32 AND NOT APPLE)
    set_property(TARGET jibooru PROPERTY OUTPUT_NAME jibooru)
endif()

target_include_directories(jibooru PRIVATE
    .
)

target_link_libraries(jibooru PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
	Qt6::QuickControls2
	Exiv2::exiv2lib
)

install(TARGETS jibooru
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(FILES jibooru.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications
)

install(FILES assets/jibooru.png
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/256x256/apps
)

# qt_generate_deploy_qml_app_script(
#     TARGET jibooru
#     FILENAME_VARIABLE deploy_script
#     NO_UNSUPPORTED_PLATFORM_ERROR
#     DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
#     MACOS_BUNDLE_POST_BUILD
# )
# install(SCRIPT ${deploy_script})
