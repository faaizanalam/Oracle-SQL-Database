CREATE TABLE sample(
sam1 NUMBER,
sam2 VARCHAR2(45),
sam3 INT,
sam4 DATE
);


COMMENT ON TABLE sample IS 'This is a sample table';
COMMENT ON COLUMN sample.sam1 IS 'This is a comment on a column 1 of sample table';