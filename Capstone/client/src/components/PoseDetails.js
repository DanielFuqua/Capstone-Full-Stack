import React, { useEffect, useContext, useState } from "react";
import { useParams } from "react-router-dom";
import { PoseContext } from "../providers/PoseProvider";
import { InstructionContext } from "../providers/InstructionProvider";
import { BenefitContext } from "../providers/BenefitProvider";
import { NoteContext } from "../providers/NoteProvider";

const PoseDetails = () => {

    const { id } = useParams();
    const [pose, setPose] = useState({});
    const { getPoseById } = useContext(PoseContext);
    const { instructions, getInstructionsByPoseId } = useContext(InstructionContext);
    const { benefits, getBenefitsByPoseId } = useContext(BenefitContext);
    const { notes, getNotesByPoseId } = useContext(NoteContext);


    useEffect(() => {
        getPoseById(parseInt(id)).then((pose) => {
            setPose(pose);
        });
        getInstructionsByPoseId(parseInt(id));
        getBenefitsByPoseId(parseInt(id));
        getNotesByPoseId(parseInt(id));
    }, []);


    return (
        <>
            <div>
                <p>{pose.nameEnglish}</p>
                <p>{pose.nameSanskrit}</p>
                <div>
                    <img src={pose.imageLocation} />
                </div>
                <div>
                    <h2>Instructions:</h2>
                    {instructions.map((inst) => <p>{inst.content}</p>)}
                </div>

                <div>
                    <h2>Benefits:</h2>
                    {benefits.map((ben) => <p>{ben.content}</p>)}
                </div>

                <div>
                    <h2>Notes:</h2>
                    {notes.map((note) => <p>{note.content}</p>)}
                </div>

            </div>



            {/* <div className="container">
                <div className="row justify-content-center">
                    <div className="col-sm-12 col-lg-6">
                        <div><img src={post.imageLocation} className="post-details-image" /></div>
                        <p className="post-details-title"><b>Post Title: </b> {post.title}</p>
                        <p className="post-details-postedBy"><b>Posted By: </b> {post.userProfile.displayName}</p>
                        <pre className="post-details-content">{post.content}</pre>
                        <p className="post-details-publishDate"><b>Publish Date: </b> {post.publishDateTime.substr(0, 10)}</p>
                        <Button onClick={() => history.push(`/newcomment/${post.id}`)} >Add Comment</Button>
                <Button onClick={toggleEdit}>Edit</Button>
                <Button onClick={toggleDelete}>Delete Post</Button>
                <Link to={`/comments/${id}`} type="button" class="btn btn-info" value="View Comments" size="sm">
            View Comments
          </Link>
                    </div>
                </div>
               
            </div> */}
        </>
    );
};
export default PoseDetails;