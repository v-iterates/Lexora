USE lexora_db;
INSERT INTO lessons(instructor_id,title,subtitle,description,language,proficiency_level,theme,reading_minutes,content_type,content,cultural_note,approval_status)
SELECT NULL,'The Lantern Seller of Lyon','A tiny light can change the shape of a street.','A beginner reading about a lantern seller and the French word for light.','French','BEGINNER','Folktales & Everyday Life',5,'READING',
'À Lyon, la ville devient dorée quand le soleil se couche.\n\nUn vieux marchand allume une petite lanterne devant sa boutique. Une enfant s’arrête et demande : « Pourquoi allumez-vous une lumière si petite ? »\n\nLe marchand sourit. « Pour que quelqu’un trouve son chemin. »\n\nL’enfant regarde la rue. La lanterne ne chasse pas toute la nuit, mais elle éclaire les prochains pas.',
'This fictional passage uses light as a metaphor for guidance. Lyon is a historic French city known for its old streets and cultural heritage.','APPROVED'
WHERE NOT EXISTS(SELECT 1 FROM lessons WHERE title='The Lantern Seller of Lyon');
INSERT INTO lessons(instructor_id,title,subtitle,description,language,proficiency_level,theme,reading_minutes,content_type,content,cultural_note,approval_status)
SELECT NULL,'A Cup of Chai','Hospitality in a familiar ritual.','A short English reading about how a cup of tea can make room for conversation.','English','BEGINNER','Rituals & Daily Life',4,'READING',
'The rain began just before dusk. At the doorway, a neighbour lifted a kettle and asked, “Will you stay for a cup of chai?”\n\nThe question was small, but it made room for a story. One cup became two; a hurried evening softened into conversation.',
'Chai is a word related to tea across several languages. Tea rituals vary by region, family, and occasion; this is a fictional scene, not a universal rule.','APPROVED'
WHERE NOT EXISTS(SELECT 1 FROM lessons WHERE title='A Cup of Chai');
INSERT INTO vocabulary(lesson_id,word,translation,pronunciation,usage_example)
SELECT lesson_id,'la lumière','light','lah loo-MYEHR','La lumière est douce.' FROM lessons WHERE title='The Lantern Seller of Lyon'
ON DUPLICATE KEY UPDATE translation=VALUES(translation);
INSERT INTO vocabulary(lesson_id,word,translation,pronunciation,usage_example)
SELECT lesson_id,'la rue','the street','lah roo','La rue est calme.' FROM lessons WHERE title='The Lantern Seller of Lyon'
ON DUPLICATE KEY UPDATE translation=VALUES(translation);
INSERT INTO vocabulary(lesson_id,word,translation,pronunciation,usage_example)
SELECT lesson_id,'un marchand','a seller / merchant','uhn mar-SHAHN','Le marchand sourit.' FROM lessons WHERE title='The Lantern Seller of Lyon'
ON DUPLICATE KEY UPDATE translation=VALUES(translation);
INSERT INTO quizzes(lesson_id,title) SELECT lesson_id,'Reading check: The Lantern Seller' FROM lessons WHERE title='The Lantern Seller of Lyon'
ON DUPLICATE KEY UPDATE title=VALUES(title);
INSERT INTO questions(quiz_id,question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
SELECT q.quiz_id,'What does “la lumière” mean?','The street','Light','The seller','The evening','B','“La lumière” means “light” in French.'
FROM quizzes q JOIN lessons l ON l.lesson_id=q.lesson_id WHERE l.title='The Lantern Seller of Lyon'
AND NOT EXISTS(SELECT 1 FROM questions WHERE quiz_id=q.quiz_id);
INSERT INTO questions(quiz_id,question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
SELECT q.quiz_id,'Why does the merchant light the lantern?','To decorate a festival','To close the shop','To help someone find their way','To scare away birds','C','The story says the lantern helps someone find their way.'
FROM quizzes q JOIN lessons l ON l.lesson_id=q.lesson_id WHERE l.title='The Lantern Seller of Lyon'
AND (SELECT COUNT(*) FROM questions WHERE quiz_id=q.quiz_id)<2;
