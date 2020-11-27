package com.example.newsappupdate.db

import androidx.room.TypeConverter
import com.example.newsappupdate.Models.Source

class Converters {

    @TypeConverter
    fun fromSource(source: Source): String {
        return source.name
    }

    @TypeConverter
    fun toSource(name: String): Source {
        return Source(name, name)
    }
}