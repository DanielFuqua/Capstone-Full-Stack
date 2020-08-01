import React, { useState, useContext } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";

export const InstructionContext = React.createContext();

export const InstructionProvider = (props) => {

    const apiUrl = "/api/instruction";
    const [instructions, setInstructions] = useState([]);

    const { getToken } = useContext(UserProfileContext);

    const getInstructionsByPoseId = (id) =>
        getToken().then((token) =>
            fetch(`/api/instruction/${id}`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            }).then((res) => res.json()).then(setInstructions));

    return (
        <InstructionContext.Provider value={{ instructions, getInstructionsByPoseId }}>
            {props.children}
        </InstructionContext.Provider>
    );
};