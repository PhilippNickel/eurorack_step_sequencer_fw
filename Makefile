CC=avr-gcc
CFLAGS=-Wall -Wextra -O2
TARGET=atmega16a
TARGETAVRDUDE=m16a
PROGRAMMER=usbasp

.PHONY:
all: prog.hex

prog.elf: src/*.c include/*.h
	avr-gcc -mmcu=$(TARGET) $(CFLAGS) src/*.c -o prog.elf

prog.hex: prog.elf
	avr-objcopy -j .text -j .data -O ihex prog.elf prog.hex

.PHONY:
debug: *.c *.h
	avr-gcc -mmcu=$(TARGET) -fverbose-asm -save-temps $(CFLAGS) src/*.c -o prog.elf

.PHONY:
flash:
	avrdude -v -c $(PROGRAMMER) -p $(TARGETAVRDUDE) -P usb -U flash:w:prog.hex

.PHONY:
clean:
	rm -f *.elf *.hex *.s *.i *.o 
