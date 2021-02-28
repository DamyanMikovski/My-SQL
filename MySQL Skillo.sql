-- 1. Брой на потребители.
select count(*) from users;

-- 2.Най-стария потребител.
select * from users order by birthDate asc limit 1;

-- 3. Най-младия потребител.
select * from users order by birthDate desc limit 1;

-- 4. Колко юзъра са регистрирани с мейли от abv и колко от gmail и колко с различни от двата.
select * from users where email like '%abv%';
select * from users where email like '%gmail%';
select * from users where email not like '%abv%' and email not like '%gmail%';

-- 5.Кои юзъри са banned.
select * from users where isBanned = 1;

-- 6. Изкарайте всички потребители от базата като ги наредите по име в азбучен ред и
-- дата на раждане(от най-младия към най-възрастния).
select * from users order by username asc , birthDate asc;

-- 7. Изкарайте всички потребители от базата, на които потребителското име започва с a.
select * from users where username like 'A%';

-- 8.Изкарайте всички потребители от базата, които съдържат а username името си.
select * from users where username like 'a%';

-- 9. Изкарайте всички потребители от базата, чието име се състои от 2 имена.
select * from users where username regexp '^[a-zA-Z]+ [a-zA-Z]+$';

-- 10. Регистрирайте 1 юзър през UI-а и го забранете след това от базата.
select * from users where username = 'DamyanSQL'
update users set isBanned=1 where username = 'DamyanSQL'

-- 11.Брой на всички постове.
select count(*) from posts;

-- 12.Брой на всички постове групирани по статуса на post-a.
select postStatus, count(*) from posts group by postStatus;

-- 13.Намерете поста/овете с най-къс caption.
select * from posts where char_length(caption) = (select min(char_length(caption)) from posts);

-- 14.Покажете поста с най-дълъг caption.
select * from posts where char_length(caption) = (select min(char_length(caption)) from posts);

-- 15. Кой потребител има най-много постове. Използвайте join заявка.
select a.id, a.username, count(*) as numberes
  from users a
  inner join posts b on (b.userId=a.id)
  group by a.id, a.username
  having count(*)=(select max(numbers) 
                    from (select count(*) as numbers
						    from posts 
						    group by userId) a)
                            
 -- 16. Кои потребители имат най-малко постовe. Използвайте join заявка.
select a.id, a.username, count(*) as numbers
  from users a
  inner join posts b on (b.userId=a.id)
  group by a.id, a.username
  having count(*)=(select min(numbers) from (select count(*) as numbers from posts group by userId) a)
  
  -- 17. Колко потребителя с по 1 пост имаме. Използвайте join заявка, having clause и вложени заявки.
  select count(*)
  from (select a.id
         from users a
         inner join posts b on (b.userId=a.id)
         group by a.id
         having count(*)=1) a 
         
 -- 18. Колко потребителя с по малко от 5 поста имаме. Използвайте join заявка, having clause и вложени заявки.        
  select count(*)
  from (select 1
         from users a
         inner join posts b on (b.userId=a.id)
         group by a.id
         having count(*)<5) a
         
 -- 19. Кои са постовете с най-много коментари. Използвайте вложена заявка и where clause
-- Ползваме броя коментари като го взимаме то posts
select a.id, a.caption
  from posts a
  where a.id in (select postId
                   from comments 
                   group by postId
                   having count(*)=(select max(broi) from (select count(*) as broi from comments group by postId) a))

-- 20. Покажете най-стария пост. Може да използвате order или с aggregate function.
select * from posts order by createdAt asc limit 1;

-- 21.Покажете най-новия пост. Може с order или с aggregate function
select * from posts order by createdAt desc limit 1;

-- 22.Покажете всички постове с празен caption.
select * from posts where trim(coalesce(caption,''))='';
select * from posts where caption is null;


-- 28. Кои потребители са like-нали най-много постове.
select a.id, a.username, count(*) as broi
  from users a
  inner join users_liked_posts b on (b.usersId=a.id)
  group by a.id, a.username

-- 29. Кои потребители не са like-вали постове.
select id,username
  from users 
  where id not in (select usersId from users_liked_posts);


