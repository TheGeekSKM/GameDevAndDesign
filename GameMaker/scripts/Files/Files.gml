enum FileType {
    FILE = 0,
    DIRECTORY = 1
}

function Directory(_name, _optionsArray) constructor {
    name = _name;
    options = _optionsArray;
    fileType = FileType.DIRECTORY;
}

function FileItem(_name, _callback) constructor {
    name = _name;
    callback = _callback;
    fileType = FileType.FILE;

    function Call() {
        if (callback != undefined) callback();
    }
}

