import React, { useState, useContext } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";

export const CommentContext = React.createContext();

export const CommentProvider = (props) => {

    const [comments, setComments] = useState([]);

    const { getToken } = useContext(UserProfileContext);

    const getCommentsByPoseId = (id) =>
        getToken().then((token) =>
            fetch(`/api/comment/${id}`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            }).then((res) => res.json()).then(setComments));

    return (
        <CommentContext.Provider value={{ comments, getCommentsByPoseId }}>
            {props.children}
        </CommentContext.Provider>
    );
};