module fstat_api.filesystem.objects;

import std.array;
import std.format;

import fstat_api.filesystem;

public interface FileSystemContainerObject {
// public:
//     @property
//     FileSystemObject[] children();
// 
//     @property
//     ulong length();
}

public class FileSystemObject {
public:
    const string name;
    const Size size;

    final this(string name, uint sizeInBytes) {
        this.name = name;
        this.size = new Size(sizeInBytes);
    }

    override string toString() const {
        return format("FileSystemObject(%s, %s)", name, size);
    }
}

public final class File : FileSystemObject {
public:
    final this(string name, uint sizeInBytes) {
        super(name, sizeInBytes);
    }
}

public final class StaticDirectory : FileSystemObject, FileSystemContainerObject {   
public:
    const ulong length; 
    const FileSystemObject[] children;

    final this(string name, uint sizeInBytes) {
        super(name, sizeInBytes);

        this.length = 0;
        this.children = [];
    }

    final this(string name, uint sizeInBytes, FileSystemObject[] childrenSeq...) {
        super(name, sizeInBytes);
        
        this.children = array(childrenSeq);
        this.length = children.length;
    }
}
