CREATE TABLE IF NOT EXISTS company (
                         id VARCHAR(255),
                         name VARCHAR(255) NOT NULL DEFAULT '' comment '公司名',
                         archived boolean DEFAULT false ,
                         default_timezone VARCHAR(255) NOT NULL DEFAULT '' comment '公司时区',
                         default_day_week_starts VARCHAR(20) NOT NULL DEFAULT 'Monday' comment '每周开始工作时间',
                         PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS directory (
                           id VARCHAR(255),
                           company_id VARCHAR(255) NOT NULL,
                           user_id VARCHAR(255) NOT NULL,
                           internal_id VARCHAR(255) NOT NULL,
                           PRIMARY KEY (id),
                           key ix_directory_company_id (company_id),
                           key ix_directory_user_id (user_id),
                           key ix_directory_internal_id (internal_id),
                           UNIQUE key ix_directory_company_user_internal_id (company_id, user_id, internal_id)
) ENGINE=InnoDB comment '公司雇员信息关联表，company和account表';

CREATE TABLE IF NOT EXISTS admin (
                       id VARCHAR(255),
                       company_id VARCHAR(255) NOT NULL,
                       user_id VARCHAR(255) NOT NULL,
                       PRIMARY KEY (id),
                       KEY ix_admin_company_id (company_id),
                       KEY ix_admin_user_id (user_id),
                       UNIQUE KEY ix_admin_company_user_id (company_id, user_id)
) ENGINE=InnoDB comment '公司管理员表';

CREATE TABLE IF NOT EXISTS team (
                      id VARCHAR(255) NOT NULL,
                      company_id VARCHAR(255) NOT NULL DEFAULT '' comment '团队公司id',
                      name VARCHAR(255) NOT NULL DEFAULT '' comment '团队名称',
                      archived boolean NOT NULL DEFAULT false,
                      timezone VARCHAR(255) NOT NULL DEFAULT '' comment '团队时区',
                      day_week_starts VARCHAR(20) NOT NULL DEFAULT 'Monday' comment '团队每周工作起始时间',
                      color VARCHAR(10) NOT NULL DEFAULT '#48B7AB' comment '团队颜色',
                      PRIMARY KEY (`id`),
                      KEY ix_team_company_id (company_id)
) ENGINE=InnoDB comment '团队表';

CREATE TABLE IF NOT EXISTS worker (
                        id VARCHAR(255),
                        team_id VARCHAR(255) NOT NULL,
                        user_id VARCHAR(255) NOT NULL,
                        PRIMARY KEY (id),
                        KEY ix_team_team_id (team_id),
                        KEY ix_team_user_id (user_id),
                        UNIQUE KEY ix_worker_team_user_id (team_id, user_id)
) ENGINE=InnoDB comment '记录雇员属于哪个团队';

CREATE TABLE IF NOT EXISTS job (
                     id VARCHAR(255) NOT NULL,
                     team_id VARCHAR(255) NOT NULL DEFAULT '',
                     name VARCHAR(255) NOT NULL DEFAULT '',
                     archived boolean NOT NULL DEFAULT false,
                     color VARCHAR(10) NOT NULL DEFAULT '#48B7AB',
                     PRIMARY KEY (id),
                     KEY ix_job_team_id (team_id)
) ENGINE=InnoDB comment '任务指派给那个团队';


CREATE TABLE IF NOT EXISTS shift (
                                   id VARCHAR(255) NOT NULL,
                                   team_id VARCHAR(255) NOT NULL DEFAULT '',
                                   job_id VARCHAR(255) NOT NULL DEFAULT '',
                                   user_id VARCHAR(255) NOT NULL DEFAULT '',
                                   published boolean NOT NULL DEFAULT false comment '是否已经发布',
                                   start TIMESTAMP NOT NULL DEFAULT current_timestamp '班次起始时间',
                                   stop TIMESTAMP NOT NULL DEFAULT current_timestamp '班次结束时间',
                                   PRIMARY KEY (id),
                                   KEY ix_job_shift_id (`job_id`),
                                   KEY ix_job_user_id (`user_id`)
) ENGINE=InnoDB comment '班次对应的团队，任务指派给那个雇员';
