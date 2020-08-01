import React, { useState, useContext } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";

export const PoseContext = React.createContext();

export const PoseProvider = (props) => {

    const apiUrl = "/api/pose";
    const [poses, setPoses] = useState([]);

    const { getToken } = useContext(UserProfileContext);

    const getAllPoses = () =>
        getToken().then((token) =>
            fetch(apiUrl, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }).then(resp => resp.json()).then(setPoses));

    const getPoseById = (id) =>
        getToken().then((token) =>
            fetch(`/api/pose/${id}`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            }).then((res) => res.json())
        );

    return (
        <PoseContext.Provider value={{ poses, getAllPoses, getPoseById }}>
            {props.children}
        </PoseContext.Provider>
    );
};