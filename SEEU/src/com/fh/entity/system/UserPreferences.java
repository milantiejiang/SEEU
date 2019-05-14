package com.fh.entity.system;

/**
 * 
* 类名称：用户喜好
* 类描述： 
 */
public class UserPreferences {
	private String USERPREFERENCES_ID;
	private String NAME; 
	private IMG ICON;
	
	public String getUSERPREFERENCES_ID() {
		return USERPREFERENCES_ID;
	}
	public void setUSERPREFERENCES_ID(String uSERPREFERENCES_ID) {
		USERPREFERENCES_ID = uSERPREFERENCES_ID;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public IMG getICON() {
		return ICON;
	}
	public void setICON(IMG iCON) {
		ICON = iCON;
	}
}
