mod GetPin
{
	//don't want to have to type 	gpio::sysfs::SysFsGpio_____::open(u16).unwrap(); every time
	//these at least reduces it to 	___Pin::open(u16).unwrap();
	use gpio::sysfs::SysFsGpioInput as InPin;
	use gpio::sysfs::SysFsGpioOutput as  OutPin;
}