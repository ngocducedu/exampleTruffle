// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TodolistTutorial {
    struct Task {
        uint256 id;
        string title;
        string description;
        uint256 startDate;
        uint256 endDate;
        bool isCompleted;
        bool isDeleted;
        uint256 createdDate;
    }

    mapping(address => mapping(uint256 => Task)) public tasks;
    mapping(address => uint256) public taskCount;

    modifier taskExisted(uint256 _taskId) {
        require(
            _taskId < taskCount[msg.sender],
            "Task with this ID does not exist"
        );
        require(
            tasks[msg.sender][_taskId].isDeleted == false,
            "Task with this ID was deleted"
        );
        _;
    }

    function createTask(
        string memory _title,
        string memory _description,
        uint256 _startDate,
        uint256 _endDate
    ) public payable {
        tasks[msg.sender][taskCount[msg.sender]] = Task(
            taskCount[msg.sender],
            _title,
            _description,
            _startDate,
            _endDate,
            false,
            false,
            block.timestamp
        );
        taskCount[msg.sender]++;
    }

    // Return amount tasks of userAddress
    function getTaskCount(address userAddress) public view returns (uint256) {
        return taskCount[userAddress];
    }

    // Return all task of userAddress
    function getAllTask(
        address userAddress
    ) public view returns (Task[] memory) {
        uint256 count = getTaskCount(userAddress);

        Task[] memory allTasks = new Task[](count);
        for (uint i = 0; i < count; i++) {
            if (tasks[userAddress][i].isDeleted == false) {
                allTasks[i] = tasks[userAddress][i];
            }
        }
        return allTasks;
    }

    function getTaskById(
        uint256 _taskId
    ) public view taskExisted(_taskId) returns (Task memory) {
        return tasks[msg.sender][_taskId];
    }

    function deleteTask(uint256 _taskId) public taskExisted(_taskId) {
        tasks[msg.sender][_taskId].isDeleted = true;
    }

    function completeTask(
        uint256 _taskId,
        bool isCompleted
    ) public taskExisted(_taskId) {
        tasks[msg.sender][_taskId].isCompleted = isCompleted;
    }
}
