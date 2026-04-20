prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>100001
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'MRDEV'
);
end;
/
 
prompt APPLICATION 100 - AparX
--
-- Application Export:
--   Application:     100
--   Name:            AparX
--   Date and Time:   11:52 Monday April 20, 2026
--   Exported By:     GOKUL
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 15737776436990906
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     2114711391975929
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/character_counter_ace
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(15737776436990906)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'CHARACTER_COUNTER_ACE'
,p_display_name=>'Character Counter [ACE]'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_api_version=>3
,p_render_function=>'ace_char_counter.render'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:READONLY:ESCAPE_OUTPUT:WIDTH:HEIGHT:ICON'
,p_substitute_attributes=>true
,p_version_scn=>30805267
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15738155010999601)
,p_plugin_id=>wwv_flow_imp.id(15737776436990906)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'max_length'
,p_prompt=>'Max Length'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'500'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15738472377005873)
,p_plugin_id=>wwv_flow_imp.id(15737776436990906)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'counter_mode'
,p_prompt=>'Counter Mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'used'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15738781970006984)
,p_plugin_attribute_id=>wwv_flow_imp.id(15738472377005873)
,p_display_sequence=>10
,p_display_value=>'Remaining'
,p_return_value=>'remaining'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15739169894007645)
,p_plugin_attribute_id=>wwv_flow_imp.id(15738472377005873)
,p_display_sequence=>20
,p_display_value=>'Used'
,p_return_value=>'used'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15739602275014617)
,p_plugin_id=>wwv_flow_imp.id(15737776436990906)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'warning_threshold'
,p_prompt=>'Warning Threshold (%)'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'20'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15739927990021948)
,p_plugin_id=>wwv_flow_imp.id(15737776436990906)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'field_type'
,p_prompt=>'Field Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'textarea'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15740269590023268)
,p_plugin_attribute_id=>wwv_flow_imp.id(15739927990021948)
,p_display_sequence=>10
,p_display_value=>'textarea'
,p_return_value=>'textarea'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15740645960024156)
,p_plugin_attribute_id=>wwv_flow_imp.id(15739927990021948)
,p_display_sequence=>20
,p_display_value=>'text'
,p_return_value=>'text'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
