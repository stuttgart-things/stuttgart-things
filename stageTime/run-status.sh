#!/bin/bash
sleep=10
failed_prs=0
succeeded_prs=0
retries=0
max_retries=3

all_prs=$(tkn pr list -n tektoncd | grep -c alpine)
echo all pipelineRuns: ${all_prs}

while [[ ${failed_prs} -le 0  ]] || [[ ${succeeded_prs} -eq ${all_prs} ]] || [[ ${retries} -eq ${max_retries} ]]
do
    echo ${retries_left} retries left
    echo check/retry in ${sleep} seconds..
    sleep ${sleep}

    failed_prs=$(tkn pr list -n tektoncd | grep alpine | grep -c Failed)
    echo Failed pipelineRuns: ${failed_prs}
    tkn pr list -n tektoncd | grep alpine | grep Failed

    succeeded_prs=$(tkn pr list -n tektoncd | grep alpine | grep -c Succeeded)
    echo Succeeded pipelineRuns: ${succeeded_prs}
    tkn pr list -n tektoncd | grep alpine | grep Succeeded

    retries=`expr ${retries} + 1`
    retries_left=`expr ${max_retries} - ${retries}`
done

echo "Done watching pipelineRuns!"
echo Failed pipelineRuns: ${failed_prs}
echo Succeeded pipelineRuns: ${succeeded_prs}