TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += $$files(../*.c)
message(SOURCES = $$SOURCES)

LIBS += -ll
