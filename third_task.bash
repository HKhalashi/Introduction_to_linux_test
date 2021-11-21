opt_help=
opt_N=
opt_s=
opt_set=
opt_h=
dir=
i=1
for arg in "$@"
 do
   let i=$i+1
   if [[ "${arg:0:1}" == "-" && -z "$opt_set" ]]
    then
     case $arg in
      --help) opt_help=1
            ;;
      -s) opt_s=1
            #echo "opt_s is $opt_s "
            eval minimal_size='$'$i
            #echo "minimal_size is $minimal_size"
            ;;
      -h) opt_h=1
            #echo "opt_h is $opt_h"
           ;;
      --) opt_set=1
             #echo "opt_set is $opt_set"
            ;;
      *)
       #echo "{arg:1} is ${arg:1}"
         if [[ "${arg:1}" -eq "${arg:1}" ]] 2>/dev/null && [[ "${arg:1}" -ge 1 ]]
           then
            opt_N=${arg:1}
            #echo "${arg:1} : is a number"
          else
               if [[ -n "${arg:1}" ]]
                then
                 #echo "${arg:1} is not a number"
                 echo "$0: invalid option '$arg'" >&2
                 exit 3
               fi
            fi

           ;;
      esac
     if [[ "$arg" == "--" ]]
       then
        opt_set=1
    # else
      # echo "Option: $arg"
       fi
   else
     #echo "Non-option: $arg"
     dir="$arg"
     if [[ "$dir" == "$minimal_size" ]]
     then
      dir=
     fi
     #echo "dir is $dir"
    fi
done
#echo ""
#echo "opt_N is $opt_N"
#echo "minimal_size is $minimal_size"
#echo ""
if [[ "$opt_help" ]]
 then

   echo "topsize prints top N largest (top size) files larger
than the specified size in the given directory and all its
subdirectories. the output contains file size and file path,
one file per line, descending order.
topsize [--help] [-h] [-N] [-s minsize] [--] [dir]

where

--help - prints help and exit
-N number of files (prints all files, if not given)
-s minsize - minimal file size (1 byte, if not given)
-h - prints human-readable size
dir - lookup directory
-- - option and non-option argument separator
---------------------------------------------
                                            "
 fi
if [[ "$dir" ]]
 then
  if [[ -d "$dir" ]]
   then
    if [[ "$opt_N" ]]
     then
      if [[ "$opt_s" ]]
       then
       if [[ "$minimal_size" -eq "$minimal_size" ]] 2>/dev/null && [[ "$minimal_size" -ge 1 ]]
        then
         if [[ "$opt_h" ]]
          then
           equal_size="$minimal_size"c
           greater_size=+"$minimal_size"c
           result=`find "$dir" -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B | tail -n "$opt_N"`
           echo "$result"
         else
          equal_size="$minimal_size"c
          greater_size=+"$minimal_size"c
          #opt_h
          result=`find "$dir" -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n | tail -n "$opt_N"`
          echo "$result"
         fi
       else
        echo "$minimal_size as minsize is invalid" >&2
        exit 2
       fi
      else
       #opt_s
       if [[ "$opt_h" ]]
          then
           result=`find "$dir" -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B | tail -n "$opt_N"`
           echo "$result"
         else
          #opt_h
          result=`find "$dir" -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n | tail -n "$opt_N"`
          echo "$result"
         fi
      fi

    else
    #opt_n
    if [[ "$opt_s" ]]
       then
       if [[ "$minimal_size" -eq "$minimal_size" ]] 2>/dev/null && [[ "$minimal_size" -ge 1 ]]
        then
         if [[ "$opt_h" ]]
          then
           equal_size="$minimal_size"c
           greater_size=+"$minimal_size"c
           result=`find "$dir" -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B`
           echo "$result"
         else
          equal_size="$minimal_size"c
          greater_size=+"$minimal_size"c
          #opt_h
          result=`find "$dir" -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n`
          echo "$result"
         fi
       else
        echo "$minimal_size minsize is invalid" >&2
        exit 2
       fi
      else
       #opt_s
       if [[ "$opt_h" ]]
          then
           result=`find "$dir" -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B`
           echo "$result"
         else
          #opt_h
          result=`find "$dir" -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n`
          echo "$result"
         fi
      fi
    fi
  else
   echo "the directory $dir is not found" >&2
   exit 1
  fi
else
#dir
if [[ "$opt_N" ]]
     then
      if [[ "$opt_s" ]]
       then
       if [[ "$minimal_size" -eq "$minimal_size" ]] 2>/dev/null && [[ "$minimal_size" -ge 1 ]]
        then
         #echo "second flag , minimal_size is $minimal_size "
         if [[ "$opt_h" ]]
          then
           equal_size="$minimal_size"c
           greater_size=+"$minimal_size"c
           result=`find -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B | tail -n "$opt_N"`
           echo "$result"
         else
          equal_size="$minimal_size"c
          greater_size=+"$minimal_size"c

          #opt_h
          result=`find -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n | tail -n "$opt_N"`
          echo "$result"
         fi
       else
        echo "$minimal_size as minsize is invalid" >&2
        exit 2
       fi
      else
       #opt_s
       if [[ "$opt_h" ]]
          then
           result=`find -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B | tail -n "$opt_N"`
           echo "$result"
         else
          #opt_h
          result=`find -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n | tail -n "$opt_N"`
          echo "$result"
         fi
      fi

    else
    #opt_n
    if [[ "$opt_s" ]]
       then
       if [[ "$minimal_size" -eq "$minimal_size" ]] 2>/dev/null && [[ "$minimal_size" -ge 1 ]]
        then
         if [[ "$opt_h" ]]
          then
           #echo "first flag"
           equal_size="$minimal_size"c
           greater_size=+"$minimal_size"c
           result=`find -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B`
           echo "$result"
         else
          #opt_h
          equal_size="$minimal_size"c
          greater_size=+"$minimal_size"c
          result=`find -size "$equal_size" -type f -printf "%s %p\n" -o -size "$greater_size" -type f -printf "%s %p\n" | sort -n`
          echo "$result"
         fi
       else
        echo "$minimal_size minsize is invalid" >&2
        exit 2
       fi
      else
       #opt_s
       if [[ "$opt_h" ]]
          then
           result=`find -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n |numfmt --to=iec-i --suffix=B`
           echo "$result"
         else
          #opt_h
          result=`find -size 1c -type f -printf "%s %p\n" -o -size +1c -type f -printf "%s %p\n" | sort -n`
          echo "$result"
         fi
      fi
    fi
fi


