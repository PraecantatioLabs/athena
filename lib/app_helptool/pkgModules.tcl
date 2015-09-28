#-----------------------------------------------------------------------
# TITLE:
#    pkgModules.tcl
#
# PROJECT:
#    athena-sim - Athena Regional Stability Simulation
#
# DESCRIPTION:
#    app_helptool(n) package modules file
#
#    Generated by Kite.
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Package Definition

# -kite-provide-start  DO NOT EDIT THIS BLOCK BY HAND
package provide app_helptool 6.3.1
# -kite-provide-end

#-----------------------------------------------------------------------
# Required Packages

# Add 'package require' statements for this package's external 
# dependencies to the following block.  Kite will update the versions 
# numbers automatically as they change in project.kite.

package require projectlib
package require athena 

# -kite-require-start ADD EXTERNAL DEPENDENCIES
package require kitedocs 0.4.11
package require Img 1.4.1
# -kite-require-end

namespace import kitedocs::* 
namespace import projectlib::*

#-----------------------------------------------------------------------
# Namespace definition

namespace eval ::app_helptool:: {
    variable library [file dirname [info script]]
}

#-----------------------------------------------------------------------
# Modules

source [file join $::app_helptool::library main.tcl]
source [file join $::app_helptool::library app.tcl]
source [file join $::app_helptool::library helpmacro.tcl]
source [file join $::app_helptool::library object.tcl]
