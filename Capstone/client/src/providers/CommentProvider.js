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

    const addComment = (comment) =>
        getToken().then((token) =>
            fetch('/api/comment', {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(comment),
            }).then((resp) => {
                return resp.json();
            })
        );

        const updateComment = (comment) =>
        getToken().then((token) =>
          fetch(`/api/comment/${comment.id}`, {
            method: "PUT",
            headers: {
              Authorization: `Bearer ${token}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify(comment),
          })
        );

        const deleteComment = (id, poseId) => {
            return getToken().then((token) =>
              fetch(`/api/comment/${id}`, {
                method: "DELETE",
                headers: {
                  Authorization: `Bearer ${token}`,
                  "Content-Type": "application/json",
                },
              }).then(getCommentsByPoseId(poseId))
            );
          };

    return (
        <CommentContext.Provider value={{ comments, getCommentsByPoseId, addComment, updateComment, deleteComment }}>
            {props.children}
        </CommentContext.Provider>
    );
};