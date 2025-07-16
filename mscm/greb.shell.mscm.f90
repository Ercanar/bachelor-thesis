subroutine init_shell
   USE mo_numerics
   USE mo_physics
   use mo_state

   implicit none

   integer :: n

   print *, '% start climate shell'

! open input files
   open (10, file='namelist')
   open (11, file='../input/ncep.tsurf.1948-2007.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (12, file='../input/ncep.zonal_wind.850hpa.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (13, file='../input/ncep.meridional_wind.850hpa.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (14, file='../input/atmospheric_humidity.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (15, file='../input/isccp.cloud_cover.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (16, file='../input/ncep.soil_moisture.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (17, file='../input/Tocean.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (18, file='../input/woce.ocean_mixed_layer_depth.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (19, file='../input/global.topography.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (20, file='../input/greb.glaciers.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*xdim*ydim)
   open (21, file='../input/solar_radiation.clim.bin', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*ydim*nstep_yr)

! read namelist
   read (10, numerics)
   read (10, physics)

! read climatologies
   do n = 1, nstep_yr
      read (11, rec=n) tclim(:, :, n)
      read (12, rec=n) uclim(:, :, n)
      read (13, rec=n) vclim(:, :, n)
      read (14, rec=n) qclim(:, :, n)
      read (15, rec=n) cldclim(:, :, n)
      read (16, rec=n) swetclim(:, :, n)
      read (17, rec=n) Toclim(:, :, n)
      read (18, rec=n) mldclim(:, :, n)
   end do

! read fix data
   read (19, rec=1) z_topo
   read (20, rec=1) glacier
   read (21, rec=1) sw_solar_ctrl

! read scenario solar forcing for paleo scenarios or oribital forcings
   if (log_exp .eq. 30 .or. log_exp .eq. 31 .or. log_exp .eq. 35 .or. log_exp .eq. 36) then
      open (22, file='solar_scenario', ACCESS='DIRECT', FORM='UNFORMATTED', RECL=ireal*ydim*nstep_yr)
      read (22, rec=1) sw_solar_scnr
   end if

! open CO2 forcing file for IPCC RCP/SSP scenarios (CO2 is read in forcing subroutine)
   if (log_exp .ge. 94 .and. log_exp .le. 105) then
      open (23, file='co2forcing')
   end if

! start greb_model run
   print *, '% time flux/control/scenario: ', time_flux, time_ctrl, time_scnr
   ! call greb_model

end subroutine
