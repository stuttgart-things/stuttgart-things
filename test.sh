TRY=6

until [ $TRY -eq 0 ] || echo this
do echo $TRY
  echo "<output message>"
  TRY=$(expr $TRY - 1)
  sleep 15
done