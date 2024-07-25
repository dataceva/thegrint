DELIMITER $$

-- Main table used in the Tableau dashboard 'Scores Dashboard'
CREATE DEFINER = `1bT12@uylp12` @`%` PROCEDURE `membership_dashboard`() BEGIN

DROP TABLE IF EXISTS thegrint_analytics.membership_dashboard;

-- START 18 hole scores --
CREATE TABLE thegrint_analytics.membership_dashboard AS

SELECT
  members.*,
  DATE(IF(@prev_user_id = members.user_id, @previous_expiration_date, NULL)) AS previous_expiration_date,
  DATE(IF(@prev_user_id = members.user_id, @previous_expiration_date, NULL)) AS secondlastexpirationdate,
  DATE(IF(@prev_user_id = members.user_id, @previous_purchase_date_sys, NULL)) AS previous_purchase_date_sys,
  DATE(IF(@prev_user_id = members.user_id, @previous_purchase_date, NULL)) AS previous_purchase_date,
  DATE(IF(@prev_user_id = members.user_id, @previous_end_membership_date, NULL)) AS previous_end_membership_date,
  @prev_user_id := members.user_id as ignore_user_id,
  @previous_expiration_date := members.expiration_date as ignore_expiration_date,
  @previous_purchase_date_sys := members.purchase_date_system as ignore_purchase_date_system,
  @previous_purchase_date := members.start_membership_date as ignore_start_membership_date,
  @previous_end_membership_date := members.end_membership_date as ignore_end_membership_date
FROM (
    SELECT
      `membership_account`.`account_id` AS `account_id`,
      `membership_type`.`active` AS `active`,
      `grint_user`.`address` AS `address`,
      `grint_user`.`admin` AS `admin`,
      `membership_payment`.`amount` AS `amount`,
      `grint_user`.`app_type` AS `app_type`,
      `membership_payment`.`auto_renewing` AS `auto_renewing`,
      `grint_user`.`avg_logins` AS `avg_logins`,
      `grint_user`.`bestFairway` AS `bestFairway`,
      `grint_user`.`bestGIR` AS `bestGIR`,
      `grint_user`.`bestPutts` AS `bestPutts`,
      `grint_user`.`bestScore` AS `bestScore`,
      `membership_payment`.`cancelation_date` AS `cancelation_date`,
      `membership_source`.`commission` AS `commission`,
      `membership_type_company`.`company_id` AS `company_id`,
      `grint_user`.`country` AS `country`,
      `grint_user`.`default_filter` AS `default_filter`,
      `grint_user`.`default_filter_round` AS `default_filter_round`,
      SUBSTRING(`membership_type`.`description_proshop`, 1, 1024) AS `description_proshop`,
      `membership_type`.`display_in_proshop` AS `display_in_proshop`,
      `grint_user`.`doj` AS `doj`,
      `membership_payment`.`expiration_date` AS `expiration_date`,
      `grint_user`.`fav_course` AS `fav_course`,
      `grint_user`.`fb_id` AS `fb_id`,
      `membership_type`.`for_amount_users` AS `for_amount_users`,
      `membership_type`.`full_price` AS `full_price`,
      `grint_user`.`gender` AS `gender`,
      `grint_user`.`grint_network` AS `grint_network`,
      `grint_user`.`handicap_index` AS `handicap_index`,
      `grint_user`.`handicap_n` AS `handicap_n`,
      `grint_user`.`hdcp_card` AS `hdcp_card`,
      `grint_user`.`hybrids` AS `hybrids`,
      `grint_user`.`image` AS `image`,
      `grint_user`.`inactive` AS `inactive`,
      `membership_type`.`is_renewable` AS `is_renewable`,
      `grint_user`.`is_winter_state` AS `is_winter_state`,
      `grint_user`.`last_login` AS `last_login`,
      `grint_user`.`life_logins` AS `life_logins`,
      `grint_user`.`map_full_access` AS `map_full_access`,
      `membership_type`.`max_api_version` AS `max_api_version`,
      `grint_user`.`member_period` AS `member_period`,
      `grint_user`.`member_type` AS `member_type`,
      `membership_account`.`membership_id` AS `membership_id (membership_account)`,
      `membership_payment`.`membership_id` AS `membership_id (membership_payment)`,
      `membership`.`membership_id` AS `membership_id`,
      `membership_account`.`membership_payment_id` AS `membership_payment_id (membership_account)`,
      `membership_payment`.`membership_payment_id` AS `membership_payment_id`,
      `membership_type`.`membership_profile_id` AS `membership_profile_id`,
      `membership_source`.`membership_source_id` AS `membership_source_id (membership_source)`,
      `membership`.`membership_source_id` AS `membership_source_id`,
      `membership_type`.`membership_type_id` AS `membership_type_id (membership_type)`,
      `membership_type_company`.`membership_type_id` AS `membership_type_id (membership_type_company)`,
      `membership`.`membership_type_id` AS `membership_type_id`,
      `membership_type`.`min_api_version` AS `min_api_version`,
      `membership_type`.`multiple` AS `multiple`,
      `membership_type`.`name` AS `name`,
      `membership_type`.`name_format` AS `name_format`,
      `membership_type`.`name_public` AS `name_public`,
      `membership_type`.`name_stripe` AS `name_stripe`,
      `grint_user`.`newsletter` AS `newsletter`,
      `grint_user`.`official_hcp_index` AS `official_hcp_index`,
      `grint_user`.`official_index` AS `official_index`,
      `grint_user`.`official_index_n` AS `official_index_n`,
      `membership_type`.`old_membership_profile_id` AS `old_membership_profile_id`,
      `membership_payment`.`on_sale` AS `on_sale`,
      `membership_type`.`on_sale_price` AS `on_sale_price`,
      `membership_type`.`only_handicap` AS `only_handicap`,
      `grint_user`.`password` AS `password`,
      `grint_user`.`payment` AS `payment`,
      `membership_type`.`period_trial` AS `period_trial`,
      `membership_payment`.`purchase_date` AS `purchase_date (membership_payment)`,
      `grint_user`.`purchase_date` AS `purchase_date`,
      `membership_payment`.`purchase_date_system` AS `purchase_date_system`,
      `grint_user`.`purchase_expired` AS `purchase_expired`,
      `grint_user`.`purchase_period` AS `purchase_period`,
      SUBSTRING(`grint_user`.`receipt_no`, 1, 1024) AS `receipt_no`,
      `grint_user`.`referrer` AS `referrer`,
      `grint_user`.`registration_source` AS `registration_source`,
      `grint_user`.`remember_login` AS `remember_login`,
      `membership_type`.`renewal_period` AS `renewal_period`,
      `grint_user`.`score_admin` AS `score_admin`,
      `grint_user`.`showwelcome` AS `showwelcome`,
      `grint_user`.`showwelcome_app` AS `showwelcome_app`,
      `membership_source`.`source` AS `source`,
      `grint_user`.`sps_counter` AS `sps_counter`,
      `grint_user`.`sps_trial_counter` AS `sps_trial_counter`,
      `grint_user`.`super_admin` AS `super_admin`,
      `membership_payment`.`transaction_amount` AS `transaction_amount`,
      `membership_payment`.`transaction_currency` AS `transaction_currency`,
      `membership_payment`.`trial_period` AS `trial_period`,
      `membership_account`.`type` AS `type`,
      `grint_user`.`user_bag` AS `user_bag`,
      `grint_user`.`user_ball` AS `user_ball`,
      `grint_user`.`user_dob` AS `user_dob`,
      `grint_user`.`user_driver` AS `user_driver`,
      `grint_user`.`user_email` AS `user_email`,
      `grint_user`.`user_fairwaywood` AS `user_fairwaywood`,
      `grint_user`.`user_fname` AS `user_fname`,
      `grint_user`.`user_hand` AS `user_hand`,
      `grint_user`.`user_homecourse` AS `user_homecourse`,
      `membership`.`user_id` AS `user_id (membership)`,
      `membership_account`.`user_id` AS `user_id (membership_account)`,
      `membership_payment`.`user_id` AS `user_id (membership_payment)`,
      `grint_user`.`user_id` AS `user_id`,
      `grint_user`.`user_irons` AS `user_irons`,
      `grint_user`.`user_lname` AS `user_lname`,
      `grint_user`.`user_putter` AS `user_putter`,
      `grint_user`.`user_username` AS `user_username`,
      `membership_type`.`valid_from` AS `valid_from`,
      `membership_type`.`valid_to` AS `valid_to`,
      `grint_user`.`verification_code` AS `verification_code`,
      `grint_user`.`verified` AS `verified`,
      `grint_user`.`website_registered` AS `website_registered`,
      `grint_user`.`wedges` AS `wedges`,
      `grint_user`.`welcome_club` AS `welcome_club`,
      `membership_account`.`whs_association_price_id` AS `whs_association_price_id`,
      `grint_user`.`zipcode` AS `zipcode`,
      wca.name AS Golf_Association,
      mrg.description AS Reporting_Product_Type,
      `membership_payment`.purchase_date as start_membership_date,
      COALESCE(`membership_payment`.cancelation_date, `membership_payment`.expiration_date) as end_membership_date
    FROM thegrint_grint.`grint_user`
    LEFT JOIN thegrint_grint.`membership` ON (`grint_user`.`user_id` = `membership`.`user_id`)
    LEFT JOIN thegrint_grint.`membership_payment` ON ((`membership`.`user_id` = `membership_payment`.`user_id`) AND (`membership`.`membership_id` = `membership_payment`.`membership_id`))
    LEFT JOIN thegrint_grint.`membership_type` ON (`membership`.`membership_type_id` = `membership_type`.`membership_type_id`)
    LEFT JOIN thegrint_grint.`membership_source` ON (`membership`.`membership_source_id` = `membership_source`.`membership_source_id`)
    LEFT JOIN thegrint_grint.`membership_type_company` ON (`membership`.`membership_type_id` = `membership_type_company`.`membership_type_id`)
    LEFT JOIN thegrint_grint.`membership_account` ON ((`membership`.`user_id` = `membership_account`.`user_id`) AND (`membership`.`membership_id` = `membership_account`.`membership_id`))
  --  LEFT JOIN thegrint_grint.`user_account` ON (`membership`.`user_id` = `user_account`.`user_id`)
    LEFT JOIN thegrint_grint.whs_club_association_zipcode AS wcaz ON grint_user.zipcode = wcaz.zipcode
    LEFT JOIN thegrint_grint.whs_club_association AS wca ON wcaz.whs_association_id = wca.whs_association_id
    LEFT JOIN thegrint_grint.membership_reporting_group AS mrg ON mrg.reporting_group_id = membership_type.reporting_group_id
    ORDER BY
      `grint_user`.`user_id`,
      `membership_payment`.`purchase_date`
  ) members
  cross join (
          SELECT
                @prev_user_id := NULL,
                @previous_expiration_date := NULL,
                @previous_purchase_date_sys := NULL,
                @previous_purchase_date := NULL,
            @previous_end_membership_date := NULL
        ) vars;

-- Create the index for the table
CREATE INDEX membership_user_id_index ON thegrint_analytics.membership_dashboard (user_id);

END$$

DELIMITER ;