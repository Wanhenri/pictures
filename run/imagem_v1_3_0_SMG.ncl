load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"


begin

i = 24
a = 1
      do while((i.le.72) .and. (a.le.3)) 
 

    ;tf = addfile("/home/smagnum/Vídeos/series/MAY2015_24Z_12Z_SMG.nc","r")
    tf = addfile("/home/smagnum/Vídeos/series/MAY2015_"+i+"Z_12Z_SMG.nc","r")
    pg = tf->prec
    
    ;*****************InformaÃ§Ãµes para plotagem***************
    
    convec	= "BAM-DAS"
    
    ;*********************************************************
    
      obg=dim_avg_n_Wrap(pg,0)
    
      wks = gsn_open_wks("eps","validation_"+i+"h_SMG")
    
    
    ;gsn_define_colormap(wks,"circular_2")			;para rodar no tupÃ£
    gsn_define_colormap(wks,"BkBlAqGrYeOrReViWh200")	;Para rodar no TupÃ£
    
    plot = new(3,graphic)
    
    
    res                     = True
    res@gsnMaximize          = True
    res@gsnAddCyclic        = False
    res@gsnFrame            = False
    res@gsnDraw             = False
    res@cnInfoLabelOn       = False   
    res@cnFillOn            = True
    res@mpOutlineOn           = True         ; Turn on map outlines
    res@lbLabelBarOn        = False  ; Habilitar ou desabilitar a legenda
    res@cnLineLabelsOn      = False
    res@cnLinesOn           = False
    
    
    res@mpLimitMode = "LatLon"	;*********************************************
    
    res@mpMinLonF = 270
    res@mpMaxLonF = 335
    res@mpMinLatF = -57		;
    res@mpMaxLatF = 13
    
    
    ;res@mpMinLonF = 0
    ;res@mpMaxLonF = 360
    ;res@mpMinLatF = -50		;
    ;res@mpMaxLatF = 50
    res@mpCenterLonF= 180
    res@mpDataBaseVersion    = "HighRes"

    res@pmTickMarkDisplayMode                     = "Always"
    
    ;******************************Niveis***********************************8
    res@cnLevelSelectionMode = "ExplicitLevels" 
    res@cnLevels                                  = (/2,4,6,8,10,12,14,16,18/)
    ;***************************************************************
    ;*****************************CORES*************************************
    ;res@cnFillColors = (/0,88,94,124,139,145,170,177,187,211/) 	; NCV_rainbow2
    ;res@cnFillColors = (/0,5, 6, 7, 8, 9, 11, 12, 13, 14/)     	; grads_rainbow
    res@cnFillColors = (/0,42,49,62,82,94,123,132,145,161/) 	; BkBlAqGrYeOrReViWh200
    
    
    ;**********************Label Bar*****************************
    
     
     ;res@lbOrientation     = "Horizontal"
     res@pmLabelBarWidthF  = 0.6            ; make thinner
     res@pmLabelBarOrthogonalPosF = .20          ; move whole thing down
     res@lbTitleOn        = True                  ; turn on title
      res@lbTitleString    = "Legenda"
    res@lbTitleFontHeightF= .015                 ; make title smaller
    
    
    
    ;************************************************************
    
    res@tiMainOffsetYF = -0.04     			;reduz o espaÃ§o entre o titulo e a imagem
    						;Start with a small negative value, and then 
    						;make it more negative if you need to move 
    						;the title closer to the plot. 
    res@tiMainFontHeightF   = 0.03   
    res@tiMainString = "Validation MAY/2015 +"+i+"Z"
    res@gsnLeftString 				= "Versao ->"+convec
    plot(0)=gsn_csm_contour_map_ce(wks,obg, res)  
    
    
    ;;res@tiMainFontHeightF   = 0.03   
    ;res@tiMainString = "Validation MAY/2015 24Z"
    ;res@gsnLeftString 				= "Versao ->"+convec
    ;plot(1)=gsn_csm_contour_map_ce(wks,obg, res)  
    ;
    ;;res@tiMainFontHeightF   = 0.03   
    ;res@tiMainString = "Validation MAY/2015 24Z"
    ;res@gsnLeftString 				= "Versao ->"+convec
    ;plot(2)=gsn_csm_contour_map_ce(wks,obg, res)  
    
    
    ;************************************************
    ; create panel
    ;************************************************
      resP                    = True                 ; modify the panel plot
       
      resP@gsnMaximize          = True 
        
      resP@gsnFrame           = False                ; don't advance panel plot
      resP@gsnPanelLabelBar   = True                 ; add common colorbar
      resP@gsnPanelBottom     = 0.05
      resP@gsnPanelMainString = "A common title"     ; new way of setting main title (as of NCL V6.3.1)
    ; resP@txString           = "A common title"     ; old way of setting main title
      ;gsn_panel(wks,plot,(/3,1/),resP)               ; now draw as one plot
      gsn_panel(wks,plot,(/1,1/),resP)               ; now draw as one plot
    
    
    ; Draw a text string at the bottom
      txres               = True
      txres@txFontHeightF = 0.015
      gsn_text_ndc(wks,"Figure "+a+": Brazilian Global Atmospheric Model(BAM)",0.5,0.05,txres)
      gsn_text_ndc(wks,"Data Assimilation",0.5,0.025,txres)
     ; gsn_text_ndc(wks,"Figure 1: A nifty panel plot",0.5,0.02,txres)
      frame(wks)
      delete(wks)
    ;system("convert -density 150 -trim -rotate -90 TESTE_24z_48Z_72Z_.eps TESTE_24z_48Z_72Z_.png ; rm TESTE_24z_48Z_72Z_.eps")
    ;system("convert -density 150 -trim -rotate -360 TESTE_24z_48Z_72Z_.eps TESTE_24z_48Z_72Z_.png ; rm TESTE_24z_48Z_72Z_.eps")
    system("convert -density 150 -trim -rotate -360 validation_"+i+"h_SMG.eps validation_"+i+"h_SMG.png ; rm validation_"+i+"h_SMG.eps")
  
  print("Imagem ->>>"+i+"h gerada")
  i=i+24
  a=a+1
end do

end
    
