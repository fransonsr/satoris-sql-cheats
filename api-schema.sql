-- users with role --
select u.username, :roleName from users u, user_roles ur, roles r
where u.user_id = ur.user_id
and ur.role_id = r.role_id
and r.name = :roleName
order by u.username;

-- user's role --
select r.name, :userName from roles r, user_roles ur, users u
where r.role_id = ur.role_id
and ur.user_id = u.user_id
and u.username = :userName
order by r.name;

-- add role to user --
insert into user_roles (user_id, role_id)
values (
  (select user_id from users where username = :userName),
  (select role_id from roles where name = :roleName)
);

-- list roles --
select name from roles
order by name;

-- roles with permission
select r.name from roles r, role_permissions rp
where r.role_id = rp.role_id
and rp.permission = :permission
order by r.name;