<?php

namespace Aws\Task\CloudFormation;
use Aws\CloudFormation\CloudFormationClient;
use Aws\CloudFormation\Exception\CloudFormationException;
use Aws\Task\AbstractTask;

/**
 * WaitForDeletionTask
 *
 * @package     Aws
 * @subpackage  CloudFormation
 * @author      Rudi Van Houdt <rudi@iadept.be>
 * @license     http://opensource.org/licenses/MIT MIT License
 */
class WaitForDeletionTask extends AbstractTask
{

    /**
     * Stack name
     * @var string
     */
    protected $name;
    protected $timeOut = 60;

    /**
     * @var CloudFormationClient
     */
    protected $service;

    /**
     * @return string $name
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param string $name
     * @return $this
     */
    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }

    /**
     * @param $timeOut
     * @return $this
     */
    public function setTimeOut($timeOut)
    {
        $this->timeOut = $timeOut;
        return $this;
    }

    /**
     * @return int $timeOut
     */
    public function getTimeOut()
    {
        return $this->timeOut;
    }

    /**
     * @return CloudFormationClient
     */
    public function getService()
    {
        if (is_null($this->service)) {
            $this->service = $this->getServiceLocator()->createCloudFormation();
        }

        return $this->service;
    }

    /**
     * Task entry point
     */
    public function main()
    {
        $this->validate();

        $cloudFormation = $this->getService();

        $stackProperties = [
            'StackName' => $this->getName(),
        ];

        $killed = false;
        $counter = 0;

        while (!$killed && $counter <= $this->getTimeOut()) {
            try {
                $cloudFormation->describeStacks($stackProperties);
            } catch (\Exception $e) {
                $killed = true;
            }

            sleep(1);

            $counter++;
        }
    }


    /**
     * Validate attributes
     *
     * @throws \BuildException
     */
    protected function validate() {

        if(!$this->getName()) {
            throw new \BuildException('You must set the name attribute.');
        }

    }

}