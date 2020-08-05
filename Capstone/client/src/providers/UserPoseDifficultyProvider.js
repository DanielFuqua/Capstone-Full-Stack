import React, { useState, useContext } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";

export const UserPoseDifficultyContext = React.createContext();

export const UserPoseDifficultyProvider = (props) => {

    const [userPoseDifficulty, setUserPoseDifficulty] = useState();

    const { getToken } = useContext(UserProfileContext);

    const getUserPoseDifficultyByPoseId = (id) =>
        getToken().then((token) =>
            fetch(`/api/userposedifficulty/${id}`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            }).then((res) => {
                if (res.status === 404) { return setUserPoseDifficulty(null) }
                else { return res.json().then(setUserPoseDifficulty) }
            }));

    const addUserPoseDifficulty = (userPoseDifficulty) =>
        getToken().then((token) =>
            fetch('/api/userposedifficulty', {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(userPoseDifficulty),
            }).then((resp) => {
                return resp.json();
            })
        );

    const updateUserPoseDifficulty = (userPoseDifficulty) =>
        getToken().then((token) =>
            fetch(`/api/userposedifficulty/${userPoseDifficulty.id}`, {
                method: "PUT",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(userPoseDifficulty),
            })
        );

    return (
        <UserPoseDifficultyContext.Provider value={{ userPoseDifficulty, getUserPoseDifficultyByPoseId, addUserPoseDifficulty, updateUserPoseDifficulty }}>
            {props.children}
        </UserPoseDifficultyContext.Provider>
    );
};