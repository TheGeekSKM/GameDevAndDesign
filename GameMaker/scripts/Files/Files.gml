enum FileType {
    FILE = 0,
    DIRECTORY = 1
}

function Directory(_name, _optionsArray, _meta = undefined) constructor {
    name = _name;
    options = _optionsArray;
    fileType = FileType.DIRECTORY;
    
    var part1 = $"{irandom_range(10, 12)}/{irandom_range(10, 28)}/2025";
    var part2 = $"{irandom_range(10, 12)}:{irandom_range(10, 59)}";
    var part3 = random(100) > 50 ? " AM" : " PM";
    
    var part4 = $"{irandom_range(10, 12)}/{irandom_range(10, 28)}/2025";
    var part5 = $"{irandom_range(10, 12)}:{irandom_range(10, 59)}";
    var part6 = random(100) > 50 ? " AM" : " PM";
    
    self.meta = _meta != undefined ? _meta : new FileMeta(
        irandom_range(1000, 999999), // random file size for example
        ($"{part1}{part2}{part3}"), // created date
        ($"{part4}{part5}{part6}")
    );
}

// function FileItem(_name, _callback) constructor {
//     name = _name;
//     callback = _callback;
//     fileType = FileType.FILE;

//     function Call() {
//         if (callback != undefined) callback();
//     }
// }


// File metadata struct
function FileMeta(_size, _created, _modified) constructor {
    self.size = _size;              // int, bytes
    self.created = _created;        // string or real (timestamp)
    self.modified = _modified;      // string or real (timestamp)
}

// Usage in FileItem
function FileItem(_name, _callback, _meta = undefined) constructor {
    self.name = _name;
    self.fileType = FileType.FILE;
    self.Call = _callback;
    
    var part1 = $"{irandom_range(10, 12)}/{irandom_range(10, 28)}/2025";
    var part2 = $"{irandom_range(10, 12)}:{irandom_range(10, 59)}";
    var part3 = random(100) > 50 ? " AM" : " PM";
    
    var part4 = $"{irandom_range(10, 12)}/{irandom_range(10, 28)}/2025";
    var part5 = $"{irandom_range(10, 12)}:{irandom_range(10, 59)}";
    var part6 = random(100) > 50 ? " AM" : " PM";
    
    self.meta = _meta != undefined ? _meta : new FileMeta(
        irandom_range(1000, 999999), // random file size for example
        ($"{part1}{part2}{part3}"), // created date
        ($"{part4}{part5}{part6}")
    );
}
