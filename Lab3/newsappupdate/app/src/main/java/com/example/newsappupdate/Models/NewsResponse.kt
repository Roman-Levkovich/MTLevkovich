package com.example.newsappupdate.Models

import com.example.newsappupdate.Models.Article
data class NewsResponse(
    val articles: MutableList<Article>,
    val status: String,
    val totalResults: Int
)