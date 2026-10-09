<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Lexora — Language, lived through stories</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lexora.css"></head><body>
<%@ include file="shared/header.jspf" %><main>
<section class="hero"><div class="hero-copy"><p class="eyebrow">✳ &nbsp; A language-learning commonplace book</p>
<h1>Every language<br>holds a <em>little world.</em></h1><p class="hero-intro">Follow a story. Gather a few words. Discover the culture living between the lines.</p>
<div class="hero-actions"><a class="button button-dark" href="#library">Enter the library ↗</a><a class="text-link" href="#method">How Lexora works ↓</a></div>
<div class="hero-note"><span class="tiny-star">✳</span><span>Small stories. Lasting discoveries.</span></div></div>
<div class="hero-art"><div class="orbit orbit-one"></div><div class="orbit orbit-two"></div><div class="moon"></div>
<div class="book"><div class="book-page page-left"><span class="page-kicker">NOTES FROM LYON</span><i class="page-rule"></i><i class="page-rule short"></i><i class="page-rule"></i><i class="page-rule medium"></i><span class="page-number">08</span></div>
<div class="book-page page-right"><span class="page-scribble">la lumière</span><i class="page-rule"></i><i class="page-rule medium"></i><i class="page-rule short"></i><span class="page-flower">✳</span><span class="page-number">09</span></div></div>
<div class="floating-note note-top"><span>01 / FRENCH</span><strong>la lumière</strong><small>light · a little clarity</small></div><div class="floating-note note-bottom"><span>FIELD NOTE</span><strong>Words carry worlds.</strong></div>
<span class="art-star star-one">✳</span><span class="art-star star-two">✦</span><div class="art-caption">A page from the commonplace book <span>✳</span></div></div>
<div class="hero-index"><span>01</span><i></i><span>03</span></div></section>
<section class="manifesto" id="method"><p class="eyebrow">THE LEXORA METHOD</p><p class="manifesto-line">Not just words to remember.<br><em>Worlds to understand.</em></p>
<div class="method-grid"><article><span class="method-number">I.</span><h3>Read a little</h3><p>Short stories and everyday scenes make a new language feel close enough to touch.</p></article>
<article><span class="method-number">II.</span><h3>Keep a word</h3><p>Meet vocabulary in context, with meaning, pronunciation notes, and an example to take with you.</p></article>
<article><span class="method-number">III.</span><h3>Find the meaning</h3><p>Gentle comprehension checks help a story settle into memory, one discovery at a time.</p></article></div></section>
<section class="library-section" id="library"><div class="section-heading"><div><p class="eyebrow">THE OPEN SHELF · 001</p><h2>Choose a doorway.</h2></div><p class="section-aside">A small collection of stories, rituals<br>and words worth keeping.</p></div>
<div class="lesson-grid"><c:forEach var="lesson" items="${lessons}" varStatus="loop"><article class="lesson-card">
<a class="lesson-art art-${loop.index % 3}" href="${pageContext.request.contextPath}/lesson?id=${lesson.lessonId}"><span class="card-index">LEXORA FIELD NOTE / 00${loop.index+1}</span>
<c:choose><c:when test="${loop.index % 3 == 0}"><span class="illustration-lantern">☼</span><span class="illustration-line"></span></c:when><c:when test="${loop.index % 3 == 1}"><span class="illustration-cup">◡</span><span class="illustration-steam">〰</span></c:when><c:otherwise><span class="illustration-star">✳</span><span class="illustration-orbit"></span></c:otherwise></c:choose><span class="card-open">↗</span></a>
<div class="lesson-meta"><span><c:out value="${lesson.language}"/></span><span>·</span><span><c:out value="${lesson.proficiencyLevel}"/></span><span class="meta-time">${lesson.readingMinutes} MIN READ</span></div>
<h3><a href="${pageContext.request.contextPath}/lesson?id=${lesson.lessonId}"><c:out value="${lesson.title}"/></a></h3><p class="lesson-subtitle"><c:out value="${lesson.subtitle}"/></p>
<a class="card-link" href="${pageContext.request.contextPath}/lesson?id=${lesson.lessonId}">Read this story <span>→</span></a></article></c:forEach>
<c:if test="${empty lessons}"><div class="empty-state"><h3>The shelves are waiting.</h3><p>Import database/seed.sql to add the starter stories.</p></div></c:if></div></section>
<section class="closing-note"><span class="closing-star">✳</span><p>“A new word is a small window.”</p><span class="closing-caption">A thought to carry into your next story</span></section></main>
<footer class="site-footer"><a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark">✳</span><span>lexora</span></a><span>Made for the curious, one story at a time.</span><span>LANGUAGE · CULTURE · CURIOSITY</span></footer>
<script src="${pageContext.request.contextPath}/assets/js/lexora.js"></script></body></html>
