@if exist install.wim del install.wim
@dism /capture-image /imagefile:iso\sources\install.wim /capturedir:X:\image /name:"Windows 11 Home" /compress:max
