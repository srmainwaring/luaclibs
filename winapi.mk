CC ?= gcc

LIBEXT=dll
LIBNAME=winapi
TARGET=$(LIBNAME).$(LIBEXT)

LIBOPT = -shared \
  -Wl,-s \
  -L..\lua\src -llua53 \
  -static-libgcc \
  -lkernel32 -luser32 -lpsapi -ladvapi32 -lshell32 -lMpr

## -lmsvcr80

CFLAGS = -Wall \
  -Wextra \
  -Wno-unused-parameter \
  -Wstrict-prototypes \
  -DPSAPI_VERSION=1 \
  -I../lua/src

## -g -O1 -DWIN32=1

SOURCES = winapi.c wutils.c wutils.h

OBJS = winapi.o wutils.o

lib: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) $(LIBOPT) -o $(TARGET)

clean:
	-$(RM) $(OBJS) $(TARGET)

$(OBJS): %.o : %.c $(SOURCES)
	$(CC) $(CFLAGS) -c -o $@ $<
