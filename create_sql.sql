use  netdisk;

DROP TABLE IF EXISTS `USERS`;
create table USERS(
	uID int not null AUTO_INCREMENT,
    uName varchar(20) not null unique,
    password varchar(20) not null,
    email varchar(30) not null unique,
    picurl varchar(255) DEFAULT NULL,
    avaliable_space int not null,
	points int not null default 0,
    primary key(uID) 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
insert into users values(1,'tian','123','aprilat@163.com','../NetDisk/assets/img/user01.jpg',102400,0);
insert into users values(2,'1','1','aprilat@169.com','../NetDisk/assets/img/timg.jpg',102400,0);

DROP TABLE IF EXISTS `src`;
create table src(
    srcID varchar(30) not null,		/*  组成为uid+时间+随机数  */
    name varchar(255) not null,
	type varchar(20) not null,  
    size varchar(20),      /*  none或者一个数字，以kb为单位  */
    edit_time datetime not null,
    srcurl varchar(255) not null,
    parentid varchar(30), 
    userid int not null ,
    state int not null default 1,
    primary key(srcID) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `public_rsrc`;
create table public_rsrc(
    srcID varchar(255) not null,
    good int not null default 0,
    bad int not null default 0,
    downloads int not null default 0,
    primary key(srcID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `comment`;
create table comment(
	srcID varchar(255) not null,
    time datetime not null,
    commenter_id int not null,
    commenter_name varchar(20) not null,
    commenter_pic varchar(255) not null,
    content text not null,
    primary key(srcID,commenter_id,time)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `attitude`;
create table attitude(
	srcID varchar(255) not null,
    uID int not null ,
    attitude int default -1,
    primary key(srcID,uID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `notice`;
create table notice(
	nid varchar(255) not null,
    /*
    classification为1，正常的资源互动check
    2，别人下载了我的资源，没有giver
    3，别人评论了我的资源或者点赞了我的资源，giver为评论者，receiver为接受者
    4，别人点了赞，giver为good或者bad，receiver为接受者
    */
    giver varchar(20),    
	receiver varchar(20),	
    classification int , /*1资源互动  2别人下载了我的资源   3别人评论了我的资源  4别人点了赞*/
	srcID varchar(255) ,
    srcSize varchar(20),
    srcName varchar(255) not null,
    time datetime not null,
    unread int not null default 1,
	primary key(nid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



