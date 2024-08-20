use bank;
select * from finance_1;
select *from finance_2;

ALTER TABLE bank.finance_1 RENAME COLUMN ï»¿id TO loan_id;
ALTER TABLE bank.finance_2 RENAME COLUMN ï»¿id TO loan_id;

-- -------------------______________________  YEAR WISE LOAN AMMOUNT STATUS ___________--------------------------------------------------------------

SELECT 
    YEAR(bank.finance_1.issue_d) AS loan_year,
    loan_status,
    SUM(bank.finance_1.loan_amnt) AS total_loan_amount,
    COUNT(bank.finance_1.loan_id) AS number_of_loans
FROM 
    bank.finance_1
GROUP BY 
    YEAR(bank.finance_1.issue_d),
    loan_status
ORDER BY 
    loan_year,
    loan_status;
    
    
-- ----------------___________________ GRADE AND SUB_GRADE WISE REVOL_BALENCE _____________________--------------------------------------------------


SELECT 
    bank.finance_1.grade,loan_id,
    bank.finance_1.sub_grade,
    sum(bank.finance_2.revol_bal) as Total_Revol_Bal,
    avg(bank.finance_2.revol_bal) as Average_Revol_bal
   
FROM 
    bank.finance_1 
join bank.finance_2 on
    bank.finance_1.loan_id = bank.finance_2.loan_id
GROUP BY 
    bank.finance_1.grade,
    bank.finance_1.sub_grade
ORDER BY 
    finance_1.grade,
    finance_1.sub_grade;
    
    
-- ----------________________ TOTAL PAYMENT FOR VERIFIED AND NON VERIFIED STATUS __________________----------------------------------------

SELECT 
    bank.finance_1.verification_status,  SUM(total_pymnt) AS total_payment 
FROM 
    finance_1 
join bank.finance_2 on bank.finance_1.loan_id=bank.finance_2.loan_id

GROUP BY 
    verification_status;
    
    
-- ----------------______________ STATE WISE AND LAST CREDITED PULL WISE LOAN STATUS ________________-----------------------------------------------------
    
    
    SELECT 
    bank.finance_1.addr_state,
    last_credit_pull_d,
    loan_status,
    COUNT(*) AS total_loans
FROM 
    finance_1
    join bank.finance_2 on bank.finance_1.loan_id=bank.finance_2.loan_id
GROUP BY 
    addr_state,
    last_credit_pull_d,
    loan_status
ORDER BY 
    addr_state,
    last_credit_pull_d;

-- ---------------------_________________  HOME OWNERSHIP VS LAST PAYMENT DATE STATUS _______________-----------------------

SELECT 
    home_ownership,
    last_pymnt_d,
    loan_status,
    COUNT(*) AS total_loans
FROM 
    finance_1
    join bank.finance_2 on bank.finance_1.loan_id=bank.finance_2.loan_id
GROUP BY 
    home_ownership,
    last_pymnt_d,
    loan_status
ORDER BY 
    home_ownership,
    last_pymnt_d;



