module fstat_api.filesystem.objects;

import std.array;
import std.format;

import fstat_api.filesystem;

public interface FileSystemContainerObject {
public:
    @property
    FileSystemObject[] children();

    @property
    ulong length();
}

public class FileSystemObject {
public:
    const string objectName;
    const Size objectSize;

    final this(string name, uint sizeInBytes) {
        this.objectName = name;
        this.objectSize = new Size(sizeInBytes);
    }

    @property
    string name() {
        return cast(string) objectName;
    } 

    @property
    Size size() {
        return cast(Size) objectSize;
    }

    override string toString() const {
        return format("FileSystemObject(%s, %s)", objectName, objectSize);
    }
}

public final class File : FileSystemObject {
public:
    final this(string name, uint sizeInBytes) {
        super(name, sizeInBytes);
    }
}

public final class StaticDirectory : FileSystemObject, FileSystemContainerObject {
private:
    const ulong childrenLength; 
    const FileSystemObject[] childrenLockedArray;
    
public:
    final this(string name, uint sizeInBytes) {
        super(name, sizeInBytes);

        this.childrenLength = 0;
        this.childrenLockedArray = [];
    }

    final this(string name, uint sizeInBytes, FileSystemObject[] childrenSeq...) {
        super(name, sizeInBytes);
        
        this.childrenLockedArray = array(childrenSeq);
        this.childrenLength = childrenLockedArray.length;
    }

    @property
    override FileSystemObject[] children() {
        return cast(FileSystemObject[]) childrenLockedArray;
    }

    @property
    override ulong length() {
        return cast(ulong) childrenLength;
    }
}
