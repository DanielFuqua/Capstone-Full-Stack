import React, { useEffect, useContext, useState } from "react";
import { useParams } from "react-router-dom";
import { CommentContext } from "../providers/CommentProvider";
import { ListGroup, ListGroupItem, Card, Form, FormGroup, Label, Input, Button } from "reactstrap";
import Comment from "./Comment";

const Comments = () => {

    const { id } = useParams();
    const { comments, getCommentsByPoseId, addComment } = useContext(CommentContext);
    const [comment, setComment] = useState();

    useEffect(() => {
        getCommentsByPoseId(parseInt(id));
    }, []);

    const handleControlledInputChange = (event) => {
        setComment(event.target.value)
    };

    const constructNewComment = () => {
        addComment({
            poseId: parseInt(id),
            content: comment,
            createDateTime: new Date()
        })
    };

    return (
        <div className="comments_container">
            <Card>
                <h2>Message Board:</h2>
                <Form>
                    <FormGroup>
                        <Label for="exampleText">Join the conversation:</Label>
                        <Input
                            type="textarea"
                            name="text"
                            id="exampleText"
                            placeholder="GOOD VIBES ONLY!"
                            onChange={handleControlledInputChange} />
                    </FormGroup>
                </Form>
                <Button
                    type="button"
                    className="btn btn-info publicMessageButton"
                    onClick={() => {
                        constructNewComment()
                        setComment("")
                    }}
                >Submit</Button>
                <ListGroup>
                    {comments.map((com) =>
                        <ListGroupItem>
                            <Comment key={com.id} com={com} />
                        </ListGroupItem>
                    )}
                </ListGroup>
            </Card>

        </div>
    );
};
export default Comments;