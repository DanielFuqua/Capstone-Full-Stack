import React, { useState, useContext } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";

export const NoteContext = React.createContext();

export const NoteProvider = (props) => {

    const [notes, setNotes] = useState([]);

    const { getToken } = useContext(UserProfileContext);

    const getNotesByPoseId = (id) =>
        getToken().then((token) =>
            fetch(`/api/note/${id}`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            }).then((res) => res.json()).then(setNotes));

    return (
        <NoteContext.Provider value={{ notes, getNotesByPoseId }}>
            {props.children}
        </NoteContext.Provider>
    );
};