export DURATION=10

userCounts=(100 )
ports=(8081 8082 8083 8084 8085 8086 8087)

for port in "${ports[@]}"; do
  export SUT_URL="http://localhost:${port}"
  for userCount in "${userCounts[@]}"; do
    export USER_COUNT=$userCount
    sleep 60
    if ! gradle gatlingRun -Dgatling.core.outputDirectoryBaseName="$port-$userCount";
    then
      echo "Loadtest for $userCount users failed for port $port. Stopping testing of current and switching to next service."
      break
    fi

  done
done

echo "Finished performance tests of ${#ports[@]} services with ${#userCounts[@]} user counts."
