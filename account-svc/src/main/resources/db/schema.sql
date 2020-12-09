CREATE TABLE IF NOT EXISTS account (
                                     id VARCHAR(255) comment '账号id' ,
                                     email VARCHAR(255) NOT NULL comment '账号邮箱',
                                     name VARCHAR(255) NOT NULL default '' comment '账号名称',
                                     phone_number VARCHAR(255) NOT NULL comment '账户电话',
                                     confirmed_and_active BOOLEAN NOT NULL DEFAULT false comment '账户是否激活',
                                     member_since TIMESTAMP NOT NULL default current_timestamp comment '账户注册开始时间点',
                                     password_hash VARCHAR(100) default '' comment '账户密码hash值',
                                     photo_url VARCHAR(255) NOT NULL comment '账户头像地址',
                                     support BOOLEAN NOT NULL DEFAULT false comment '是否是staffjoy支持用户',
                                     PRIMARY KEY (id),
                                     key ix_account_email (email),
                                     key ix_account_phone_number (phone_number)
) ENGINE=InnoDB;

-- time-zone issue reference
-- https://blog.csdn.net/CHS007chs/article/details/81348291
