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

    const addNote = (note) =>
        getToken().then((token) =>
            fetch('/api/note', {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(note),
            }).then((resp) => {
                return resp.json();
            })
        );

    const updateNote = (note) =>
        getToken().then((token) =>
            fetch(`/api/note/${note.id}`, {
                method: "PUT",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(note),
            })
        );

    const deleteNote = (id, poseId) => {
        return getToken().then((token) =>
            fetch(`/api/note/${id}`, {
                method: "DELETE",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                },
            }).then(getNotesByPoseId(poseId))
        );
    };

    return (
        <NoteContext.Provider value={{ notes, getNotesByPoseId, addNote, updateNote, deleteNote }}>
            {props.children}
        </NoteContext.Provider>
    );
};