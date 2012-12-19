Attribute VB_Name = "AstroModule"
Option Explicit
Public PLine(7) As String, FirstCusp As Single
Public Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long
Public Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Public TheLibrary As Long
Public Declare Function AddFontResource _
                        Lib "gdi32" Alias "AddFontResourceA" _
                        (ByVal lpFileName As String) As Long

Public Declare Function RemoveFontResource _
                        Lib "gdi32" Alias "RemoveFontResourceA" _
                        (ByVal lpFileName As String) As Long

' Swiss Ephemeris Release 1.60  9-jan-2000
'
' Declarations for Visual Basic 5.0
' The DLL file must exist in the same directory as the VB executable, or in a system
' directory where it can be found at runtime
'
Public ascmc(10) As Double
Public PlanetAngle(7) As Double
Public Type orient
    i As Long
    s As String * 16
End Type
'
' Declarations for Visual Basic 5.0
' The DLL file must exist in the same directory as the VB executable, or in a system
' directory where it can be found at runtime
'

Public Declare Function swe_azalt Lib "swedll32.dll" _
                        Alias "_swe_azalt@40" ( _
                        ByVal tjd_ut As Double, _
                        ByVal calc_flag As Long, _
                        ByRef geopos As Double, _
                        ByVal atpress As Double, _
                        ByVal attemp As Double, _
                        ByRef xin As Double, _
                        ByRef xaz As Double _
                        ) As Long  'geopos must be the first of three array elements
'xin must be the first of two array elements
'xaz must be the first of three array elements

Public Declare Function swe_azalt_rev Lib "swedll32.dll" _
                        Alias "_swe_azalt_rev@24" ( _
                        ByVal tjd_ut As Double, _
                        ByVal calc_flag As Long, _
                        ByRef geopos As Double, _
                        ByRef xin As Double, _
                        ByRef xout As Double _
                        ) As Long  'geopos must be the first of three array elements
'xin must be the first of two array elements
'xout must be the first of three array elements

Public Declare Function swe_calc Lib "swedll32.dll" _
                        Alias "_swe_calc@24" ( _
                        ByVal tjd As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long   ' x must be first of six array elements
' serr must be able to hold 256 bytes

Public Declare Function swe_calc_d Lib "swedll32.dll" _
                        Alias "_swe_calc_d@20" ( _
                        ByRef tjd As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long       ' x must be first of six array elements
' serr must be able to hold 256 bytes

Public Declare Function swe_calc_ut Lib "swedll32.dll" _
                        Alias "_swe_calc_ut@24" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long   ' x must be first of six array elements
' serr must be able to hold 256 bytes

Public Declare Function swe_calc_ut_d Lib "swedll32.dll" _
                        Alias "_swe_calc_ut_d@20" ( _
                        ByRef tjd_ut As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long       ' x must be first of six array elements
' serr must be able to hold 256 bytes

Public Declare Function swe_close Lib "swedll32.dll" _
                        Alias "_swe_close@0" ( _
                        ) As Long

Public Declare Function swe_close_d Lib "swedll32.dll" _
                        Alias "_swe_close_d@4" ( _
                        ByVal ivoid As Long _
                        ) As Long       ' argument ivoid is ignored

Public Declare Sub swe_cotrans Lib "swedll32.dll" _
                        Alias "_swe_cotrans@16" ( _
                        ByRef xpo As Double, _
                        ByRef xpn As Double, _
                        ByVal eps As Double _
                        )

Public Declare Function swe_cotrans_d Lib "swedll32.dll" _
                        Alias "_swe_cotrans_d@12" ( _
                        ByRef xpo As Double, _
                        ByRef xpn As Double, _
                        ByRef eps As Double _
                        ) As Long

Public Declare Sub swe_cotrans_sp Lib "swedll32.dll" _
                        Alias "_swe_cotrans_sp@16" ( _
                        ByRef xpo As Double, _
                        ByRef xpn As Double, _
                        ByVal eps As Double _
                        )

Public Declare Function swe_cotrans_sp_d Lib "swedll32.dll" _
                        Alias "_swe_cotrans_sp_d@12" ( _
                        ByRef xpo As Double, _
                        ByRef xpn As Double, _
                        ByRef eps As Double _
                        ) As Long

Public Declare Sub swe_cs2degstr Lib "swedll32.dll" _
                        Alias "_swe_cs2degstr@8" ( _
                        ByVal t As Long, _
                        ByVal s As String _
                        )

Public Declare Function swe_cs2degstr_d Lib "swedll32.dll" _
                        Alias "_swe_cs2degstr_d@8" ( _
                        ByVal t As Long, _
                        ByVal s As String _
                        ) As Long

Public Declare Sub swe_cs2lonlatstr Lib "swedll32.dll" _
                        Alias "_swe_cs2lonlatstr@16" ( _
                        ByVal t As Long, _
                        ByVal pchar As Byte, _
                        ByVal mchar As Byte, _
                        ByVal s As String _
                        )

Public Declare Function swe_cs2lonlatstr_d Lib "swedll32.dll" _
                        Alias "_swe_cs2lonlatstr_d@16" ( _
                        ByVal t As Long, _
                        ByRef pchar As Byte, _
                        ByRef mchar As Byte, _
                        ByVal s As String _
                        ) As Long

Public Declare Sub swe_cs2timestr Lib "swedll32.dll" _
                        Alias "_swe_cs2timestr@16" ( _
                        ByVal t As Long, _
                        ByVal sep As Long, _
                        ByVal supzero As Long, _
                        ByVal s As String _
                        )

Public Declare Function swe_cs2timestr_d Lib "swedll32.dll" _
                        Alias "_swe_cs2timestr_d@16" ( _
                        ByVal t As Long, _
                        ByVal sep As Long, _
                        ByVal supzero As Long, _
                        ByVal s As String _
                        ) As Long

Public Declare Function swe_csnorm Lib "swedll32.dll" _
                        Alias "_swe_csnorm@4" ( _
                        ByVal p As Long _
                        ) As Long

Public Declare Function swe_csnorm_d Lib "swedll32.dll" _
                        Alias "_swe_csnorm_d@4" ( _
                        ByVal p As Long _
                        ) As Long

Public Declare Function swe_csroundsec Lib "swedll32.dll" _
                        Alias "_swe_csroundsec@4" ( _
                        ByVal p As Long _
                        ) As Long

Public Declare Function swe_csroundsec_d Lib "swedll32.dll" _
                        Alias "_swe_csroundsec_d@4" ( _
                        ByVal p As Long _
                        ) As Long

Public Declare Function swe_d2l Lib "swedll32.dll" _
                        Alias "_swe_d2l@8" ( _
                        ) As Long

Public Declare Function swe_d2l_d Lib "swedll32.dll" _
                        Alias "_swe_d2l_d@4" ( _
                        ) As Long

Public Declare Function swe_date_conversion Lib "swedll32.dll" _
                        Alias "_swe_date_conversion@28" ( _
                        ByVal Year As Long, _
                        ByVal Month As Long, _
                        ByVal Day As Long, _
                        ByVal utime As Double, _
                        ByVal cal As Byte, _
                        ByRef tjd As Double _
                        ) As Long

Public Declare Function swe_date_conversion_d Lib "swedll32.dll" _
                        Alias "_swe_date_conversion_d@24" ( _
                        ByVal Year As Long, _
                        ByVal Month As Long, _
                        ByVal Day As Long, _
                        ByRef utime As Double, _
                        ByRef cal As Byte, _
                        ByRef tjd As Double _
                        ) As Long

Public Declare Function swe_day_of_week Lib "swedll32.dll" _
                        Alias "_swe_day_of_week@8" ( _
                        ByVal jd As Double _
                        ) As Long

Public Declare Function swe_day_of_week_d Lib "swedll32.dll" _
                        Alias "_swe_day_of_week_d@4" ( _
                        ByRef jd As Double _
                        ) As Long

Public Declare Function swe_degnorm Lib "swedll32.dll" _
                        Alias "_swe_degnorm@8" ( _
                        ByVal jd As Double _
                        ) As Double

Public Declare Function swe_degnorm_d Lib "swedll32.dll" _
                        Alias "_swe_degnorm_d@4" ( _
                        ByRef jd As Double _
                        ) As Long

Public Declare Function swe_deltat Lib "swedll32.dll" _
                        Alias "_swe_deltat@8" ( _
                        ByVal jd As Double _
                        ) As Double

Public Declare Function swe_deltat_d Lib "swedll32.dll" _
                        Alias "_swe_deltat_d@8" ( _
                        ByRef jd As Double, _
                        ByRef deltat As Double _
                        ) As Long

Public Declare Function swe_difcs2n Lib "swedll32.dll" _
                        Alias "_swe_difcs2n@8" ( _
                        ByVal p1 As Long, _
                        ByVal p2 As Long _
                        ) As Long

Public Declare Function swe_difcs2n_d Lib "swedll32.dll" _
                        Alias "_swe_difcs2n_d@8" ( _
                        ByVal p1 As Long, _
                        ByVal p2 As Long _
                        ) As Long

Public Declare Function swe_difcsn Lib "swedll32.dll" _
                        Alias "_swe_difcsn@8" ( _
                        ByVal p1 As Long, _
                        ByVal p2 As Long _
                        ) As Long

Public Declare Function swe_difcsn_d Lib "swedll32.dll" _
                        Alias "_swe_difcsn_d@8" ( _
                        ByVal p1 As Long, _
                        ByVal p2 As Long _
                        ) As Long

Public Declare Function swe_difdeg2n Lib "swedll32.dll" _
                        Alias "_swe_difdeg2n@16" ( _
                        ByVal p1 As Double, _
                        ByVal p2 As Double _
                        ) As Double

Public Declare Function swe_difdeg2n_d Lib "swedll32.dll" _
                        Alias "_swe_difdeg2n_d@12" ( _
                        ByRef p1 As Double, _
                        ByRef p2 As Double, _
                        ByRef diff As Double _
                        ) As Long

Public Declare Function swe_difdegn Lib "swedll32.dll" _
                        Alias "_swe_difdegn@16" ( _
                        ByVal p1 As Double, _
                        ByVal p2 As Double _
                        ) As Long

Public Declare Function swe_difdegn_d Lib "swedll32.dll" _
                        Alias "_swe_difdegn_d@12" ( _
                        ByRef p1 As Double, _
                        ByRef p2 As Double, _
                        ByRef diff As Double _
                        ) As Long

Public Declare Function swe_fixstar Lib "swedll32.dll" _
                        Alias "_swe_fixstar@24" ( _
                        ByVal star As String, _
                        ByVal tjd As Double, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long       ' x must be first of six array elements
' serr must be able to hold 256 bytes
' star must be able to hold 40 bytes

Public Declare Function swe_fixstar_d Lib "swedll32.dll" _
                        Alias "_swe_fixstar_d@20" ( _
                        ByVal star As String, _
                        ByRef tjd As Double, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long       ' x must be first of six array elements
' serr must be able to hold 256 bytes
' star must be able to hold 40 bytes

Public Declare Function swe_fixstar_ut Lib "swedll32.dll" _
                        Alias "_swe_fixstar_ut@24" ( _
                        ByVal star As String, _
                        ByVal tjd_ut As Double, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long       ' x must be first of six array elements
' serr must be able to hold 256 bytes
' star must be able to hold 40 bytes

Public Declare Function swe_fixstar_ut_d Lib "swedll32.dll" _
                        Alias "_swe_fixstar_ut_d@20" ( _
                        ByVal star As String, _
                        ByRef tjd_ut As Double, _
                        ByVal iflag As Long, _
                        ByRef X As Double, _
                        ByVal serr As String _
                        ) As Long       ' x must be first of six array elements
' serr must be able to hold 256 bytes
' star must be able to hold 40 bytes

Public Declare Function swe_get_ayanamsa Lib "swedll32.dll" _
                        Alias "_swe_get_ayanamsa@8" ( _
                        ByVal tjd_et As Double _
                        ) As Double

Public Declare Function swe_get_ayanamsa_d Lib "swedll32.dll" _
                        Alias "_swe_get_ayanamsa_d@8" ( _
                        ByRef tjd_et As Double, _
                        ByRef ayan As Double _
                        ) As Long

Public Declare Function swe_get_ayanamsa_ut Lib "swedll32.dll" _
                        Alias "_swe_get_ayanamsa_ut@8" ( _
                        ByVal tjd_ut As Double _
                        ) As Double

Public Declare Function swe_get_ayanamsa_ut_d Lib "swedll32.dll" _
                        Alias "_swe_get_ayanamsa_ut_d@8" ( _
                        ByRef tjd_ut As Double, _
                        ByRef ayan As Double _
                        ) As Long

Public Declare Sub swe_get_planet_name Lib "swedll32.dll" _
                        Alias "_swe_get_planet_name@8" ( _
                        ByVal ipl As Long, _
                        ByVal pname As String _
                        )

Public Declare Function swe_get_planet_name_d Lib "swedll32.dll" _
                        Alias "_swe_get_planet_name_d@8" ( _
                        ByVal ipl As Long, _
                        ByVal pname As String _
                        ) As Long

Public Declare Function swe_get_tid_acc Lib "swedll32.dll" _
                        Alias "_swe_get_tid_acc@0" ( _
                        ) As Double

Public Declare Function swe_get_tid_acc_d Lib "swedll32.dll" _
                        Alias "_swe_get_tid_acc_d@4" ( _
                        ByRef X As Double _
                        ) As Long

Public Declare Function swe_houses Lib "swedll32.dll" _
                        Alias "_swe_houses@36" ( _
                        ByVal tjd_ut As Double, _
                        ByVal geolat As Double, _
                        ByVal geolon As Double, _
                        ByVal ihsy As Long, _
                        ByRef hcusps As Double, _
                        ByRef ascmc As Double _
                        ) As Long       ' hcusps must be first of 13 array elements
' ascmc must be first of 10 array elements

Public Declare Function swe_houses_d Lib "swedll32.dll" _
                        Alias "_swe_houses_d@24" ( _
                        ByRef tjd_ut As Double, _
                        ByRef geolat As Double, _
                        ByRef geolon As Double, _
                        ByVal ihsy As Long, _
                        ByRef hcusps As Double, _
                        ByRef ascmc As Double _
                        ) As Long       ' hcusps must be first of 13 array elements
' ascmc must be first of 10 array elements

Public Declare Function swe_houses_ex Lib "swedll32.dll" _
                        Alias "_swe_houses_ex@40" ( _
                        ByVal tjd_ut As Double, _
                        ByVal iflag As Long, _
                        ByVal geolat As Double, _
                        ByVal geolon As Double, _
                        ByVal ihsy As Long, _
                        ByRef hcusps As Double, _
                        ByRef ascmc As Double _
                        ) As Long       ' hcusps must be first of 13 array elements
' ascmc must be first of 10 array elements

Public Declare Function swe_houses_ex_d Lib "swedll32.dll" _
                        Alias "_swe_houses_ex_d@28" ( _
                        ByRef tjd_ut As Double, _
                        ByVal iflag As Long, _
                        ByRef geolat As Double, _
                        ByRef geolon As Double, _
                        ByVal ihsy As Long, _
                        ByRef hcusps As Double, _
                        ByRef ascmc As Double _
                        ) As Long       ' hcusps must be first of 13 array elements
' ascmc must be first of 10 array elements

Public Declare Function swe_houses_armc Lib "swedll32.dll" _
                        Alias "_swe_houses_armc@36" ( _
                        ByVal armc As Double, _
                        ByVal geolat As Double, _
                        ByVal eps As Double, _
                        ByVal ihsy As Long, _
                        ByRef hcusps As Double, _
                        ByRef ascmc As Double _
                        ) As Long       ' hcusps must be first of 13 array elements
' ascmc must be first of 10 array elements

Public Declare Function swe_houses_armc_d Lib "swedll32.dll" _
                        Alias "_swe_houses_armc_d@24" ( _
                        ByRef armc As Double, _
                        ByRef geolat As Double, _
                        ByRef eps As Double, _
                        ByVal ihsy As Long, _
                        ByRef hcusps As Double, _
                        ByRef ascmc As Double _
                        ) As Long       ' hcusps must be first of 13 array elements
' ascmc must be first of 10 array elements

Public Declare Function swe_house_pos Lib "swedll32.dll" _
                        Alias "_swe_house_pos@36" ( _
                        ByVal armc As Double, _
                        ByVal geolat As Double, _
                        ByVal eps As Double, _
                        ByVal ihsy As Long, _
                        ByRef xpin As Double, _
                        ByVal serr As String _
                        ) As Double
' xpin must be first of 2 array elements

Public Declare Function swe_house_pos_d Lib "swedll32.dll" _
                        Alias "_swe_house_pos_d@28" ( _
                        ByRef armc As Double, _
                        ByRef geolat As Double, _
                        ByRef eps As Double, _
                        ByVal ihsy As Long, _
                        ByRef xpin As Double, _
                        ByRef hpos As Double, _
                        ByVal serr As String _
                        ) As Long
' xpin must be first of 2 array elements

Public Declare Function swe_julday Lib "swedll32.dll" _
                        Alias "_swe_julday@24" ( _
                        ByVal Year As Long, _
                        ByVal Month As Long, _
                        ByVal Day As Long, _
                        ByVal hour As Double, _
                        ByVal gregflg As Long _
                        ) As Double

Public Declare Function swe_julday_d Lib "swedll32.dll" _
                        Alias "_swe_julday_d@24" ( _
                        ByVal Year As Long, _
                        ByVal Month As Long, _
                        ByVal Day As Long, _
                        ByRef hour As Double, _
                        ByVal gregflg As Long, _
                        ByRef tjd As Double _
                        ) As Long

Public Declare Function swe_lun_eclipse_how Lib "swedll32.dll" _
                        Alias "_swe_lun_eclipse_how@24" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ifl As Long, _
                        ByRef geopos As Double, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_lun_eclipse_how_d Lib "swedll32.dll" _
                        Alias "_swe_lun_eclipse_how_d@20" ( _
                        ByRef tjd_ut As Double, _
                        ByVal ifl As Long, _
                        ByRef geopos As Double, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_lun_eclipse_when Lib "swedll32.dll" _
                        Alias "_swe_lun_eclipse_when@28" ( _
                        ByVal tjd_start As Double, _
                        ByVal ifl As Long, _
                        ByVal ifltype As Long, _
                        ByRef tret As Double, _
                        ByVal backward As Long, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_lun_eclipse_when_d Lib "swedll32.dll" _
                        Alias "_swe_lun_eclipse_when_d@24" ( _
                        ByRef tjd_start As Double, _
                        ByVal ifl As Long, _
                        ByVal ifltype As Long, _
                        ByRef tret As Double, _
                        ByVal backward As Long, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_nod_aps Lib "swedll32.dll" _
                        Alias "_swe_nod_aps@40" ( _
                        ByVal tjd_et As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByVal method As Long, _
                        ByRef xnasc As Double, _
                        ByRef xndsc As Double, _
                        ByRef xperi As Double, _
                        ByRef xaphe As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_nod_aps_ut Lib "swedll32.dll" _
                        Alias "_swe_nod_aps_ut@40" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByVal method As Long, _
                        ByRef xnasc As Double, _
                        ByRef xndsc As Double, _
                        ByRef xperi As Double, _
                        ByRef xaphe As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_pheno Lib "swedll32.dll" _
                        Alias "_swe_pheno@24" ( _
                        ByVal tjd As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_pheno_ut Lib "swedll32.dll" _
                        Alias "_swe_pheno_ut@24" ( _
                        ByVal tjd As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_pheno_d Lib "swedll32.dll" _
                        Alias "_swe_pheno_d@20" ( _
                        ByRef tjd As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_pheno_ut_d Lib "swedll32.dll" _
                        Alias "_swe_pheno_ut_d@20" ( _
                        ByRef tjd As Double, _
                        ByVal ipl As Long, _
                        ByVal iflag As Long, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_refrac Lib "swedll32.dll" _
                        Alias "_swe_refrac@28" ( _
                        ByVal inalt As Double, _
                        ByVal atpress As Double, _
                        ByVal attemp As Double, _
                        ByVal calc_flag As Long _
                        ) As Double

Public Declare Sub swe_revjul Lib "swedll32.dll" _
                        Alias "_swe_revjul@28" ( _
                        ByVal tjd As Double, _
                        ByVal gregflg As Long, _
                        ByRef Year As Long, _
                        ByRef Month As Long, _
                        ByRef Day As Long, _
                        ByRef hour As Double _
                        )

Public Declare Function swe_revjul_d Lib "swedll32.dll" _
                        Alias "_swe_revjul_d@24" ( _
                        ByRef tjd As Double, _
                        ByVal gregflg As Long, _
                        ByRef Year As Long, _
                        ByRef Month As Long, _
                        ByRef Day As Long, _
                        ByRef hour As Double _
                        ) As Long

Public Declare Function swe_rise_trans Lib "swedll32.dll" _
                        Alias "_swe_rise_trans@52" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ipl As Long, _
                        ByVal starname As String, _
                        ByVal epheflag As Long, _
                        ByVal rsmi As Long, _
                        ByRef geopos As Double, _
                        ByVal atpress As Double, _
                        ByVal attemp As Double, _
                        ByRef tret As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Sub swe_set_ephe_path Lib "swedll32.dll" _
                        Alias "_swe_set_ephe_path@4" ( _
                        ByVal path As String _
                        )

Public Declare Function swe_set_ephe_path_d Lib "swedll32.dll" _
                        Alias "_swe_set_ephe_path_d@4" ( _
                        ByVal path As String _
                        ) As Long

Public Declare Sub swe_set_jpl_file Lib "swedll32.dll" _
                        Alias "_swe_set_jpl_file@4" ( _
                        ByVal file As String _
                        )

Public Declare Function swe_set_jpl_file_d Lib "swedll32.dll" _
                        Alias "_swe_set_jpl_file_d@4" ( _
                        ByVal file As String _
                        ) As Long

Public Declare Function swe_set_sid_mode Lib "swedll32.dll" _
                        Alias "_swe_set_sid_mode@20" ( _
                        ByVal sid_mode As Long, _
                        ByVal t0 As Double, _
                        ByVal ayan_t0 As Double _
                        ) As Long

Public Declare Function swe_set_sid_mode_d Lib "swedll32.dll" _
                        Alias "_swe_sid_mode_d@12" ( _
                        ByVal sid_mode As Long, _
                        ByRef t0 As Double, _
                        ByRef ayan_t0 As Double _
                        ) As Long

Public Declare Sub swe_set_topo Lib "swedll32.dll" _
                        Alias "_swe_set_topo@24" ( _
                        ByVal geolon As Double, _
                        ByVal geolat As Double, _
                        ByVal altitude As Double _
                        )

Public Declare Function swe_set_topo_d Lib "swedll32.dll" _
                        Alias "_swe_set_topo_d@12" ( _
                        ByRef geolon As Double, _
                        ByRef geolat As Double, _
                        ByRef altitude As Double _
                        ) As Long

Public Declare Sub swe_set_tid_acc Lib "swedll32.dll" _
                        Alias "_swe_set_tid_acc@8" ( _
                        ByVal X As Double _
                        )

Public Declare Function swe_set_tid_acc_d Lib "swedll32.dll" _
                        Alias "_swe_set_tid_acc_d@4" ( _
                        ByRef X As Double _
                        ) As Long

Public Declare Function swe_sidtime0 Lib "swedll32.dll" _
                        Alias "_swe_sidtime0@24" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ecl As Double, _
                        ByVal nut As Double _
                        ) As Double

Public Declare Function swe_sidtime0_d Lib "swedll32.dll" _
                        Alias "_swe_sidtime0_d@16" ( _
                        ByRef tjd_ut As Double, _
                        ByRef ecl As Double, _
                        ByRef nut As Double, _
                        ByRef sidt As Double _
                        ) As Long

Public Declare Function swe_sidtime Lib "swedll32.dll" _
                        Alias "_swe_sidtime@8" ( _
                        ByVal tjd_ut As Double _
                        ) As Double

Public Declare Function swe_sidtime_d Lib "swedll32.dll" _
                        Alias "_swe_sidtime_d@8" ( _
                        ByRef tjd_ut As Double, _
                        ByRef sidt As Double _
                        ) As Long

Public Declare Function swe_sol_eclipse_how Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_how@24" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ifl As Long, _
                        ByRef geopos As Double, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_how_d Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_how_d@20" ( _
                        ByRef tjd_ut As Double, _
                        ByVal ifl As Long, _
                        ByRef geopos As Double, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_when_glob Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_when_glob@28" ( _
                        ByVal tjd_start As Double, _
                        ByVal ifl As Long, _
                        ByVal ifltype As Long, _
                        ByRef tret As Double, _
                        ByVal backward As Long, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_when_glob_d Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_when_glob_d@24" ( _
                        ByRef tjd_start As Double, _
                        ByVal ifl As Long, _
                        ByVal ifltype As Long, _
                        ByRef tret As Double, _
                        ByVal backward As Long, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_when_loc Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_when_loc@32" ( _
                        ByVal tjd_start As Double, _
                        ByVal ifl As Long, _
                        ByRef tret As Double, _
                        ByRef attr As Double, _
                        ByVal backward As Long, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_when_loc_d Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_when_loc_d@28" ( _
                        ByRef tjd_start As Double, _
                        ByVal ifl As Long, _
                        ByRef tret As Double, _
                        ByRef attr As Double, _
                        ByVal backward As Long, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_where Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_where@24" ( _
                        ByVal tjd_ut As Double, _
                        ByVal ifl As Long, _
                        ByRef geopos As Double, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_sol_eclipse_where_d Lib "swedll32.dll" _
                        Alias "_swe_sol_eclipse_where_d@20" ( _
                        ByRef tjd_ut As Double, _
                        ByVal ifl As Long, _
                        ByRef geopos As Double, _
                        ByRef attr As Double, _
                        ByVal serr As String _
                        ) As Long

Public Declare Function swe_time_equ Lib "swedll32.dll" _
                        Alias "_swe_time_equ@16" ( _
                        ByVal tjd_ut As Double, _
                        ByRef e As Double, _
                        ByVal serr As String _
                        ) As Long

' values for gregflag in swe_julday() and swe_revjul()
Public Const SE_JUL_CAL As Integer = 0
Public Const SE_GREG_CAL As Integer = 1

' planet and body numbers (parameter ipl) for swe_calc()
Public Const SE_SUN As Integer = 0
Public Const SE_MOON As Integer = 1
Public Const SE_MERCURY As Integer = 2
Public Const SE_VENUS As Integer = 3
Public Const SE_MARS As Integer = 4
Public Const SE_JUPITER As Integer = 5
Public Const SE_SATURN As Integer = 6
Public Const SE_URANUS As Integer = 7
Public Const SE_NEPTUNE As Integer = 8
Public Const SE_PLUTO   As Integer = 9
Public Const SE_MEAN_NODE As Integer = 10
Public Const SE_TRUE_NODE As Integer = 11
Public Const SE_MEAN_APOG As Integer = 12
Public Const SE_OSCU_APOG As Integer = 13
Public Const SE_EARTH     As Integer = 14
Public Const SE_CHIRON    As Integer = 15
Public Const SE_PHOLUS    As Integer = 16
Public Const SE_CERES     As Integer = 17
Public Const SE_PALLAS    As Integer = 18
Public Const SE_JUNO      As Integer = 19
Public Const SE_VESTA     As Integer = 20

Public Const SE_NPLANETS  As Integer = 21
Public Const SE_AST_OFFSET  As Integer = 10000

' Hamburger or Uranian ficticious "planets"
Public Const SE_FICT_OFFSET As Integer = 40
Public Const SE_FICT_MAX  As Integer = 999 'maximum number for ficticious planets
'if taken from file seorbel.txt
Public Const SE_NFICT_ELEM  As Integer = 15 'number of built-in ficticious planets
Public Const SE_CUPIDO As Integer = 40
Public Const SE_HADES As Integer = 41
Public Const SE_ZEUS As Integer = 42
Public Const SE_KRONOS As Integer = 43
Public Const SE_APOLLON As Integer = 44
Public Const SE_ADMETOS As Integer = 45
Public Const SE_VULKANUS As Integer = 46
Public Const SE_POSEIDON As Integer = 47
' other ficticious bodies
Public Const SE_ISIS As Integer = 48
Public Const SE_NIBIRU As Integer = 49
Public Const SE_HARRINGTON As Integer = 50
Public Const SE_NEPTUNE_LEVERRIER As Integer = 51
Public Const SE_NEPTUNE_ADAMS As Integer = 52
Public Const SE_PLUTO_LOWELL As Integer = 53
Public Const SE_PLUTO_PICKERING As Integer = 54

' points returned by swe_houses() and swe_houses_armc()
' in array ascmc(0...10)
Public Const SE_ASC       As Integer = 0
Public Const SE_MC        As Integer = 1
Public Const SE_ARMC      As Integer = 2
Public Const SE_VERTEX    As Integer = 3
Public Const SE_EQUASC    As Integer = 4  ' "equatorial ascendant"
Public Const SE_NASCMC    As Integer = 5  ' number of such points

' iflag values for swe_calc()/swe_calc_ut() and swe_fixstar()/swe_fixstar_ut()
Public Const SEFLG_JPLEPH As Long = 1
Public Const SEFLG_SWIEPH As Long = 2
Public Const SEFLG_MOSEPH As Long = 4
Public Const SEFLG_SPEED As Long = 256
Public Const SEFLG_HELCTR As Long = 8
Public Const SEFLG_TRUEPOS As Long = 16
Public Const SEFLG_J2000 As Long = 32
Public Const SEFLG_NONUT As Long = 64
Public Const SEFLG_NOGDEFL As Long = 512
Public Const SEFLG_NOABERR As Long = 1024
Public Const SEFLG_EQUATORIAL As Long = 2048
Public Const SEFLG_XYZ As Long = 4096
Public Const SEFLG_RADIANS As Long = 8192
Public Const SEFLG_BARYCTR As Long = 16384
Public Const SEFLG_TOPOCTR As Long = 32768
Public Const SEFLG_SIDEREAL As Long = 65536

'eclipse codes
Public Const SE_ECL_CENTRAL As Long = 1
Public Const SE_ECL_NONCENTRAL As Long = 2
Public Const SE_ECL_TOTAL As Long = 4
Public Const SE_ECL_ANNULAR As Long = 8
Public Const SE_ECL_PARTIAL As Long = 16
Public Const SE_ECL_ANNULAR_TOTAL As Long = 32
Public Const SE_ECL_PENUMBRAL As Long = 64
Public Const SE_ECL_VISIBLE As Long = 128
Public Const SE_ECL_MAX_VISIBLE As Long = 256
Public Const SE_ECL_1ST_VISIBLE As Long = 512
Public Const SE_ECL_2ND_VISIBLE As Long = 1024
Public Const SE_ECL_3RD_VISIBLE As Long = 2048
Public Const SE_ECL_4TH_VISIBLE As Long = 4096

'sidereal modes, for swe_set_sid_mode()
Public Const SE_SIDM_FAGAN_BRADLEY    As Long = 0
Public Const SE_SIDM_LAHIRI           As Long = 1
Public Const SE_SIDM_DELUCE           As Long = 2
Public Const SE_SIDM_RAMAN            As Long = 3
Public Const SE_SIDM_USHASHASHI       As Long = 4
Public Const SE_SIDM_KRISHNAMURTI     As Long = 5
Public Const SE_SIDM_DJWHAL_KHUL      As Long = 6
Public Const SE_SIDM_YUKTESHWAR       As Long = 7
Public Const SE_SIDM_JN_BHASIN        As Long = 8
Public Const SE_SIDM_BABYL_KUGLER1    As Long = 9
Public Const SE_SIDM_BABYL_KUGLER2   As Long = 10
Public Const SE_SIDM_BABYL_KUGLER3   As Long = 11
Public Const SE_SIDM_BABYL_HUBER     As Long = 12
Public Const SE_SIDM_BABYL_ETPSC     As Long = 13
Public Const SE_SIDM_ALDEBARAN_15TAU As Long = 14
Public Const SE_SIDM_HIPPARCHOS      As Long = 15
Public Const SE_SIDM_SASSANIAN       As Long = 16
Public Const SE_SIDM_GALCENT_0SAG    As Long = 17
Public Const SE_SIDM_J2000           As Long = 18
Public Const SE_SIDM_J1900           As Long = 19
Public Const SE_SIDM_B1950           As Long = 20
Public Const SE_SIDM_USER            As Long = 255

Public Const SE_NSIDM_PREDEF         As Long = 21

Public Const SE_SIDBITS              As Long = 256
'for projection onto ecliptic of t0
Public Const SE_SIDBIT_ECL_T0        As Long = 256
'for projection onto solar system plane
Public Const SE_SIDBIT_SSY_PLANE     As Long = 512

' modes for planetary nodes/apsides, swe_nod_aps(), swe_nod_aps_ut()
Public Const SE_NODBIT_MEAN        As Long = 1
Public Const SE_NODBIT_OSCU        As Long = 2
Public Const SE_NODBIT_OSCU_BAR    As Long = 3
Public Const SE_NODBIT_FOPOINT     As Long = 256

' indices for swe_rise_trans()
Public Const SE_CALC_RISE      As Long = 1
Public Const SE_CALC_SET       As Long = 2
Public Const SE_CALC_MTRANSIT      As Long = 4
Public Const SE_CALC_ITRANSIT      As Long = 8
Public Const SE_BIT_DISC_CENTER        As Long = 256 '/* to be added to SE_CALC_RISE/SET */
'/* if rise or set of disc center is */
'/* requried */
Public Const SE_BIT_NO_REFRACTION      As Long = 512 '/* to be added to SE_CALC_RISE/SET, */
'/* if refraction is not to be considered */

' bits for data conversion with swe_azalt() and swe_azalt_rev()
Public Const SE_ECL2HOR        As Long = 0
Public Const SE_EQU2HOR        As Long = 1
Public Const SE_HOR2ECL        As Long = 0
Public Const SE_HOR2EQU        As Long = 1

' for swe_refrac()
Public Const SE_TRUE_TO_APP        As Long = 0
Public Const SE_APP_TO_TRUE        As Long = 1

Public iday%
Public iMonth%
Public iYear%
Public ihour%
Public imin
Public starname As String
Public Lon As Single
Public Lat As Single
Public tjd_ut
Public tjd_et
Public TZone As Single

Public Declare Sub GetSystemTime Lib "kernel32" (lpSystemTime As SYSTEMTIME)
Public Type SYSTEMTIME
    wYear As Integer
    wMonth As Integer
    wDayOfWeek As Integer
    wDay As Integer
    wHour As Integer
    wMinute As Integer
    wSecond As Integer
    wMilliseconds As Integer
End Type
Public Declare Function GetTimeZoneInformation _
   Lib "kernel32" (lpTimeZoneInformation As _
   TIME_ZONE_INFORMATION) As Long
Public Type TIME_ZONE_INFORMATION
   Bias As Long
   StandardName(0 To 63) As Byte
   StandardDate As SYSTEMTIME
   StandardBias As Long
   DaylightName(0 To 63) As Byte
   DaylightDate As SYSTEMTIME
   DaylightBias As Long
End Type
Public Const TIME_ZONE_ID_INVALID = &HFFFFFFFF
Public Const TIME_ZONE_ID_UNKNOWN = 0
Public Const TIME_ZONE_ID_STANDARD = 1
Public Const TIME_ZONE_ID_DAYLIGHT = 2

Public Function set_strlen(c$) As String

  Dim i As Integer

    i = InStr(c$, Chr$(0))
    If (i > 0) Then c$ = Left(c$, i - 1)
    set_strlen = c$

End Function

Public Function outdeg(X As Double) As String

  Dim fract As Double, Min As Integer, sec As Integer

    fract = Abs(X) - Int(Abs(X))
    Min = Int(fract * 60)
    sec = fract * 3600 - Min * 60
    outdeg = Format(Sgn(X) * Int(Abs(X)), "###0") + "°" + Format(Min, "00") + "'" + Format(sec, "00")

End Function

Public Function outdeg3(X As Double) As String

  Dim fract As Double, Min As Integer, sec As Integer

    fract = Abs(X) - Int(Abs(X))
    Min = Int(fract * 60)
    sec = fract * 3600 - Min * 60
    outdeg3 = Format(Sgn(X) * Int(Abs(X)), "000") + "°" + Format(Min, "00") + "'" + Format(sec, "00")

End Function

Public Sub CalcPlanets(TheDate As Date)

  Dim X(6) As Double
  Dim x2(6) As Double
  Dim cusp(13) As Double
  Dim attr(20) As Double
  Dim tret(20) As Double
  Dim geopos(10) As Double
  Dim geoposx(10) As Double
  Dim xnasc(6) As Double
  Dim xndsc(6) As Double
  Dim xperi(6) As Double
  Dim xaphe(6) As Double
  Dim cal As Byte
  Dim o As orient
  Dim ss As String * 16
  Dim h As Double, olen As Integer, retval As Long, t2 As Double
  Dim ut As String, planet As Integer, iflag As Integer, serr As String, plnam As String
  Dim ret_flag As Integer, i As Integer

    cal = 103  ' g for gregorian calendar
    h = ihour% + imin / 60#
    olen = LenB(ss)
    geopos(0) = Lon
    geopos(1) = Lat
    geopos(2) = 0
'     the next two functions do the same job, converting a calendar date
'     into a Julian day number
'     swe_date_conversion() checks for legal dates while swe_julday() handles
'     even illegal things like 45 Januar etc.
    Dim TheTDate As Date
    Dim Xc As Long ' scratch
Dim uTZI As TIME_ZONE_INFORMATION
Dim dtNow As Date ' current system time
Dim dtGMT As Date ' current GMT time
Dim lBias As Long ' current offset
Dim sName As String ' current tz name
Dim sDS As String ' Daylight Savings?
Dim sInfo As String ' scratch
Select Case GetTimeZoneInformation(uTZI)
  ' if not daylight assume standard
  Case TIME_ZONE_ID_DAYLIGHT:
    sName = uTZI.DaylightName ' convert to string
    lBias = uTZI.Bias + uTZI.DaylightBias
    sDS = "Daylight Savings Time is in effect"
  Case Else:
    sName = uTZI.StandardName
    lBias = uTZI.Bias + uTZI.StandardBias
    sDS = "Daylight Savings Time is not in effect"
End Select
' name terminates with null
Xc = InStr(sName, vbNullChar)
If Xc > 0 Then sName = Left$(sName, Xc - 1)
dtNow = Now ' get time
dtGMT = DateAdd("n", lBias, dtNow) ' calculate GMT
TheTDate = dtGMT

    TheTDate = DateAdd("h", TZone, TheDate)
    iYear = Year(TheTDate)
    iMonth = Month(TheTDate)
    iday = Day(TheTDate)
    h = hour(TheTDate) + Minute(TheTDate) / 60 + Second(TheTDate) / 3600
    tjd_ut = swe_julday(iYear%, iMonth%, iday%, h, 1)
    'retval = swe_date_conversion(iYear, iMonth, iday, h, cal, tjd_ut)
    If retval <> 0 Then
        Call MsgBox("Illegal Date", vbOKOnly)
        Exit Sub
    End If
  Dim et_flag As Boolean
    et_flag = True
    If et_flag Then
        tjd_et = tjd_ut
        tjd_ut = tjd_et - swe_deltat(tjd_et)
      Else
        tjd_et = tjd_ut + swe_deltat(tjd_ut)
    End If
    t2 = tjd_ut - 2415018.5
    If t2 < 0 Then
        t2 = t2
    End If
    If tjd_ut = tjd_et Then
        ut$ = ""
      Else
        ut$ = "  UT=" + Format(tjd_ut, "0.00000")
    End If
    '    PLine(0) = "ET=" & tjd_et & vbTab & ut$
    PLine(0) = Trim$(ut$)
    For planet = SE_SUN To SE_SATURN 'SE_PLUTO_PICKERING
        iflag = SEFLG_SPEED + SEFLG_SWIEPH
        '        If bary_flag = 1 Then
        '            iflag = iflag + SEFLG_BARYCTR
        '        End If
        '        If hel_flag = 1 Then
        '            iflag = iflag + SEFLG_HELCTR
        '        End If
        '        If is_j2000 = 1 Then
        '            iflag = iflag + SEFLG_J2000
        '        End If
        '        If Not is_apparent = 1 Then
        '           iflag = iflag + SEFLG_TRUEPOS
        '        End If
        '        If is_sidereal = 1 Then
        '           iflag = iflag + SEFLG_SIDEREAL
        '        End If
        serr$ = String(255, 0)
        plnam$ = String(20, 0)
        ret_flag = swe_calc(tjd_et, planet, iflag, X(0), serr$)
        serr$ = set_strlen(serr$)
        If ret_flag <> iflag And Len(serr$) > 0 And InStr(serr$, "SwissEph file 'sepl") = 0 Then
            'frmArsMagna.txtOut = frmArsMagna.txtOut & "swe_calc reports: " & serr$
        End If
        Call swe_get_planet_name(planet, plnam$)
        plnam$ = set_strlen(plnam$)
        plnam$ = Left(plnam$, 10)
        PlanetAngle(planet) = X(0)
        PLine(planet + 1) = plnam$ & vbTab & outdeg3(X(0)) & vbTab & outdeg(X(1)) & vbTab & Format(X(2), "0.000")
        '        If planet = SE_VESTA Then
        '          If add_hypo = 0 Then Exit For
        '          planet = SE_CUPIDO    ' skip undefined planet numbers
        '          out = out & ""
        '        End If
    Next planet
  Dim tmp As Double
    tmp = PlanetAngle(0)
    PlanetAngle(0) = PlanetAngle(1)
    PlanetAngle(1) = PlanetAngle(2)
    PlanetAngle(2) = PlanetAngle(3)
    PlanetAngle(3) = tmp
    '     If with_houses Then
    '       out = out & ""
    ret_flag = swe_houses_ex(tjd_ut, iflag, Lat, Lon, Asc("P"), cusp(0), ascmc(0))
    FirstCusp = cusp(1)
    PLine(0) = PLine(0) & vbTab & "Asc=" & outdeg3(ascmc(0)) & vbTab & "MC=" & outdeg3(ascmc(1))
    'Debug.Print ascmc(0), ascmc(1)
    '     For i = 1 To 12
    '        ' x(0) = cusp(i)
    '        ' x(1) = 0
    '        out = out & "House " & vbTab & i & vbTab & outdeg3(cusp(i))   ' outdeg3(x(1)),
    '        If i Mod 3 = 0 Then out = out & ""
    '       Next i
    '     End If
    swe_close

End Sub
