import React, { useContext, useState } from "react";
import { Button, Modal, ModalBody, Card, Form, FormGroup, Label, Input, CardTitle, CardText } from "reactstrap";
import { useParams } from "react-router-dom";
import { NoteContext } from "../providers/NoteProvider";
import "./Notes.css";


const Note = ({ note }) => {

    const { updateNote, deleteNote, getNotesByPoseId } = useContext(NoteContext);
    const [theNote, setTheNote] = useState();
    const { id } = useParams();

    const handleControlledInputChange = (event) => {
        setTheNote(event.target.value)
    };

    const [editModal, setEditModal] = useState(false);

    const [deleteModal, setDeleteModal] = useState(false);

    const toggleEdit = () => {
        setEditModal(!editModal);
    };

    const toggleDelete = () => {
        setDeleteModal(!deleteModal);
    };

    const reconstructNote = () => {
        updateNote({
            id: parseInt(note.id),
            poseId: parseInt(id),
            content: theNote,
            createDateTime: note.createDateTime
        }).then(() => getNotesByPoseId(parseInt(id)))
    };

    return (
        <>
            <Card className="note_card" body>
                <CardTitle className="note_card_date">{new Date(note.createDateTime).toLocaleDateString('en-us')}</CardTitle>
                <CardText className="note_cardText">{note.content}</CardText>
                <div className="note_card_buttons">
                    <i class="far fa-edit" onClick={toggleEdit}></i>
                    <i class="far fa-trash-alt" onClick={toggleDelete}></i>
                </div>
            </Card>

            <Modal isOpen={editModal} toggle={toggleEdit}>
                <ModalBody>

                    <Form>
                        <FormGroup>
                            <Label for="exampleText">Make a change to your note:</Label>
                            <Input
                                type="textarea"
                                name="text"
                                id="exampleText"
                                defaultValue={note.content}
                                onChange={handleControlledInputChange} />
                        </FormGroup>
                    </Form>
                    <Button
                        type="button"
                        className="btn btn-info publicMessageButton"
                        onClick={() => {
                            reconstructNote();
                            setTheNote("");
                            toggleEdit();
                        }}
                    >Submit</Button>

                </ModalBody>
            </Modal>

            <Modal isOpen={deleteModal} toggle={toggleDelete}>
                <ModalBody>
                    <Form>
                        <FormGroup>
                            <Label for="exampleText">Would you like to delete this note?</Label>
                        </FormGroup>
                    </Form>
                    <Button
                        type="button"
                        className="btn btn-info deleteButton"
                        onClick={() => {
                            deleteNote(note.id, parseInt(id));
                            toggleDelete();
                        }}
                    >Delete</Button>

                </ModalBody>
            </Modal>

        </>
    )
};

export default Note;