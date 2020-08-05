import React, { useState, useEffect, useContext } from "react";
import { Card, Alert, ButtonGroup, Button } from "reactstrap";
import { UserPoseDifficultyContext } from "../providers/UserPoseDifficultyProvider";
import { useParams } from "react-router-dom";

const UserPoseDifficulty = () => {

    const { id } = useParams();
    const [rSelected, setRSelected] = useState(null);
    const { userPoseDifficulty, addUserPoseDifficulty, getUserPoseDifficultyByPoseId } = useContext(UserPoseDifficultyContext);

    useEffect(() => {
        getUserPoseDifficultyByPoseId(parseInt(id));
    }, []);

    useEffect(() => {
        if (rSelected === null) { return }

        addUserPoseDifficulty({
            poseId: parseInt(id),
            difficulty: rSelected,
        }).then(() => getUserPoseDifficultyByPoseId(parseInt(id)));
    }, [rSelected]);

    const constructNewUserPoseDifficulty = (num) => {
        setRSelected(num);
    };
    
    return (
        <Card className="user_pose_difficulty_container">
            {!userPoseDifficulty
                ?
                <Alert color="light">
                    Feel free to rate this posture's difficulty!
            </Alert>
                :
                <Alert color="success">
                    Difficulty Rating: {userPoseDifficulty.difficulty}
                </Alert>}

            <ButtonGroup>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(1)} active={rSelected === 1}>1</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(2)} active={rSelected === 2}>2</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(3)} active={rSelected === 3}>3</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(4)} active={rSelected === 4}>4</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(5)} active={rSelected === 5}>5</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(6)} active={rSelected === 6}>6</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(7)} active={rSelected === 7}>7</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(8)} active={rSelected === 8}>8</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(9)} active={rSelected === 9}>9</Button>
                <Button size="sm" className="difficulty_button" color="primary" onClick={() => constructNewUserPoseDifficulty(10)} active={rSelected === 10}>10</Button>
            </ButtonGroup>
        </Card>
    )
};

export default UserPoseDifficulty;