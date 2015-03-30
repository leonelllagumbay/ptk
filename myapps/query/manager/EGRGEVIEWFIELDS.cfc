component
persistent="true" table="EGRGEVIEWFIELDS"
{
	property name="EVIEWFIELDCODE" fieldtype="id";
	property name="EGRGQRYCOLUMN" cfc="EGRGQRYCOLUMN" fieldtype="one-to-one" cascade="all-delete-orphan";
	property name="TABLENAME";
	property name="EQRYCODEFK";
	property name="FIELDNAME";
	property name="DISPLAY";
	property name="FIELDALIAS";
	property name="PRIORITYNO";
	property name="AGGREGATEFUNC";
	property name="DATEANDSTRINGFUNC";
	property name="NUMBERFORMAT";
	property name="ISDISTINCT";
	property name="WRAPON";
	property name="SUPPRESSZERO";
	property name="OVERRIDESTATEMENT";
	property name="COLUMNORDER";
	property name="IS_PRIMARYKEY";
	property name="ORDINAL_POSITION";
	property name="TYPE_NAME";
	property name="DECIMAL_DIGITS";
	property name="IS_NULLABLE";
	property name="COLUMN_DEFAULT_VALUE";
	property name="CHAR_OCTET_LENGTH";
	property name="IS_FOREIGNKEY";
	property name="REFERENCED_PRIMARYKEY";
	property name="REFERENCED_PRIMARYKEY_TABLE";
}