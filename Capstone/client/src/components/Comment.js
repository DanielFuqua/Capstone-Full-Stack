import React, { useContext, useState } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";
import { Button, Modal, ModalBody, Card, Form, FormGroup, Label, Input } from "reactstrap";
import { CommentContext } from "../providers/CommentProvider";
import { useParams } from "react-router-dom";

const Comment = ({ com }) => {

    const { userProfile } = useContext(UserProfileContext);
    const { updateComment, deleteComment, getCommentsByPoseId } = useContext(CommentContext);
    const theUserProfile = JSON.parse(userProfile);
    const [comment, setComment] = useState();
    const { id } = useParams();

    const handleControlledInputChange = (event) => {
        setComment(event.target.value)
    };

    const [editModal, setEditModal] = useState(false);

    const [deleteModal, setDeleteModal] = useState(false);


    const toggleEdit = () => {
        setEditModal(!editModal);
    };

    const toggleDelete = () => {
        setDeleteModal(!deleteModal);
    };

    const reconstructComment = () => {
        updateComment({
            id: parseInt(com.id),
            poseId: parseInt(id),
            content: comment,
            createDateTime: com.createDateTime
        }).then(() => getCommentsByPoseId(parseInt(id)))
    };

    return (
        <>
            <div>
                <p>{com.userProfile.displayName}</p>
                <p>{com.content}</p>
                <p>{new Date(com.createDateTime).toLocaleDateString('en-us')}</p>
                {com.userProfileId === theUserProfile.id && (
                    <Button onClick={toggleEdit}>Edit</Button>
                )}
                {com.userProfileId === theUserProfile.id && (
                    <Button onClick={toggleDelete}>Delete</Button>
                )}
            </div>

            <Modal isOpen={editModal} toggle={toggleEdit}>
                <ModalBody>

                    <Form>
                        <FormGroup>
                            <Label for="exampleText">Make a change to your comment:</Label>
                            <Input
                                type="textarea"
                                name="text"
                                id="exampleText"
                                defaultValue={com.content}
                                onChange={handleControlledInputChange} />
                        </FormGroup>
                    </Form>
                    <Button
                        type="button"
                        className="btn btn-info publicMessageButton"
                        onClick={() => {
                            reconstructComment();
                            setComment("");
                            toggleEdit();
                        }}
                    >Submit</Button>

                </ModalBody>
            </Modal>

            <Modal isOpen={deleteModal} toggle={toggleDelete}>
                <ModalBody>
                    <Form>
                        <FormGroup>
                            <Label for="exampleText">Would you like to delete this comment?</Label>
                        </FormGroup>
                    </Form>
                    <Button
                        type="button"
                        className="btn btn-info deleteButton"
                        onClick={() => {
                            deleteComment(com.id, parseInt(id));
                            toggleDelete();
                        }}
                    >Delete</Button>

                </ModalBody>
            </Modal>

        </>
    )
};

export default Comment;