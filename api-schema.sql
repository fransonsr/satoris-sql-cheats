-- users with role --
select u.username, :roleName from users u, user_roles ur, roles r
where u.user_id = ur.user_id
and ur.role_id = r.role_id
and r.name = :roleName
order by u.username;

-- user's user roles --
select r.name, :userName from roles r, user_roles ur, users u
where r.role_id = ur.role_id
and ur.user_id = u.user_id
and u.username = :userName
order by r.name;

-- user's group roles --
select r.name, :userName as username, g.name as groupname
from roles r, users u, group_roles gr, groups g
where r.role_id = gr.role_id
and gr.group_id = g.group_id
and gr.user_id = u.user_id
and u.username = :userName
order by r.name;

-- user's project roles --
select r.name, :userName as username, p.name as projectname
from roles r, users u, project_roles pr, projects p
where r.role_id = pr.role_id
and pr.project_id = p.project_id
and pr.user_id = u.user_id
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

-- permissions for role
select rp.permission from role_permissions rp, roles r
where r.role_id = rp.role_id
and r.name = :roleName
order by rp.permission;

-- users with user role count
select u.username, count(1) as role_count
from users u, user_roles ur
where u.user_id = ur.user_id
group by ur.user_id
order by role_count desc;