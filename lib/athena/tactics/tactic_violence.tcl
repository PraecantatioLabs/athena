#-----------------------------------------------------------------------
# TITLE:
#    tactic_violence.tcl
#
# AUTHOR:
#    Will Duquette
#
# DESCRIPTION:
#    athena(n): Mark II Tactic, VIOLENCE event
#
#    This module implements the VIOLENCE tactic. 
#
#-----------------------------------------------------------------------

#-------------------------------------------------------------------
# Tactic: VIOLENCE

::athena::tactic define VIOLENCE "Violence Event" {system actor} {
    #-------------------------------------------------------------------
    # Instance Variables

    # Editable Parameters
    variable n          ;# Neighborhood in which to create violence
    variable coverage   ;# Coverage fraction

    #-------------------------------------------------------------------
    # Constructor

    constructor {pot_ args} {
        next $pot_

        # Initialize state variables
        set n          ""
        set coverage   0.5

        # Initial state is invalid (no n)
        my set state invalid

        my configure {*}$args
    }

    #-------------------------------------------------------------------
    # Operations

    # No ObligateResources method is required; the tactic uses no resources.

    method SanityCheck {errdict} {
        if {$n eq ""} {
            dict set errdict n "No neighborhood selected."
        } elseif {$n ni [[my adb] nbhood names]} {
            dict set errdict n "No such neighborhood: \"$n\"."
        }

        return [next $errdict]
    }

    method narrative {} {
        set narr ""

        set s(n)        [::athena::link make nbhood $n]
        set s(coverage) [format "%.2f" $coverage]

        set narr "VIOLENCE abstract event in $s(n) "
        append narr "(cov=$s(coverage))."
        
        return $narr
    }

    method execute {} {
        set owner [my agent]

        set s(n)        [::athena::link make nbhood $n]
        set s(coverage) [format "%.2f" $coverage]

        # NEXT, log execution
        set objects [list $owner $n]

        set msg "VIOLENCE([my id]): [my narrative]"

        [my adb] sigevent log 2 tactic $msg {*}$objects

        # NEXT, create the violence.
        [my adb] abevent add VIOLENCE $n $coverage
    }
}

# TACTIC:VIOLENCE
#
# Creates/Updates VIOLENCE tactic.

::athena::orders define TACTIC:VIOLENCE {
    meta title      "Tactic: Violence Event"
    meta sendstates PREP
    meta parmlist {tactic_id name n coverage}

    meta form {
        rcc "Tactic ID" -for tactic_id
        text tactic_id -context yes \
            -loadcmd {$order_ beanload}

        rcc "Name:" -for name
        text name -width 20

        rcc "Neighborhood:" -for n
        nbhood n

        rcc "Coverage:" -for coverage
        frac coverage
    }

    method _validate {} {
        # FIRST, prepare the parameters
        my prepare tactic_id  -required \
            -with [list $adb strategy valclass ::athena::tactic::VIOLENCE]
        my returnOnError

        set tactic [$adb bean get $parms(tactic_id)]

        # Validation of initially invalid items or contingent items
        # takes place on sanity check.
        my prepare name      -toupper   -with [list $tactic valName]
        my prepare n         -toupper
        my prepare coverage  -num       -type rfraction

        my returnOnError

        my checkon coverage {
            if {$parms(coverage) == 0.0} {
                my reject coverage "Coverage must be greater than 0."
            }
        }
    }

    method _execute {{flunky ""}} {
        set tactic [$adb bean get $parms(tactic_id)]
        my setundo [$tactic update_ {
            name n coverage
        } [array get parms]]
    }
}





