ifneq ($(KERNELRELEASE),)

obj-m := hello.o

ccflags-y += -g

else

KDIR ?= /lib/modules/$(shell uname -r)/build

PWD := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules
	cp hello.ko hello.ko.unstripped
	$(CROSS_COMPILE)strip -g hello.ko

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

%.s %.i: %.c
	$(MAKE) -C $(KDIR) M=$(PWD) $@

endif

